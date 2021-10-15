"""Provides a function prepare_data."""

import os
from dataclasses import dataclass
from typing import Any, Callable, Dict, Iterable, List, Tuple, Union

import numpy as np
import pandas as pd
from sklearn.model_selection import KFold

from src.util import make_columns_lower_case

ORGANISMS_TO_INCLUDE = [
    "Escherichia coli",
    "Homo sapiens",
    "Saccharomyces cerevisiae",
]
NON_NULL_COLS = ["ec4", "km", "organism", "substrate"]
EXTRA_NULL_VALUES = ["more", -999]
NUMBER_REGEX = r"\d*\.?\d+"
TEMP_REGEX = (
    fr"({NUMBER_REGEX}-{NUMBER_REGEX}|{NUMBER_REGEX}) ?(&ordm;|&deg;)[Cc]"
)
PH_REGEX = fr"[pP][hH] ({NUMBER_REGEX})"
MOL_REGEX = fr".* ({NUMBER_REGEX}) ?[mM]"
COFACTORS = [
    "ATP",
    "NADH",
    "NAD+",
    "NADPH",
    "acetyl-CoA",
    "NADP+",
    "ADP",
]
BIOLOGY_FCTS = ["ec4", "organism", "substrate"]
THIS_FILE = os.path.dirname(os.path.abspath(__file__))

# types
StanDict = Dict[str, Union[float, int, List[float], List[int]]]


@dataclass
class PrepareDataOutput:
    stan_input_prior: StanDict
    stan_input_posterior: StanDict
    stan_inputs_cv: List[StanDict]
    coords: Dict[str, Any]
    dims: Dict[str, Any]
    df: pd.DataFrame
    splits: Iterable[Tuple]


PrepFunc = Callable[[pd.DataFrame, int], PrepareDataOutput]


@dataclass
class PrepareDataInput:
    prepare_func: PrepFunc
    pp: pd.DataFrame
    k: int
    name: str


def replace_nulls_with_empty_set(s: pd.Series) -> pd.Series:
    """Work around not being able to pass sets to pd.Series.fillna."""
    return pd.Series(np.where(s.notnull(), s, frozenset()), index=s.index)


def preprocess(km: pd.DataFrame, nat: pd.DataFrame) -> pd.DataFrame:
    """Add extra columns to the raw data and tidy some names."""
    out = (
        km.copy()
        .rename(
            columns={
                "ecNumber": "ec4",
                "kmValue": "km",
                "ligandStructureId": "ligand_structure_id",
            }
        )
        .replace(EXTRA_NULL_VALUES, np.nan)
        .pipe(make_columns_lower_case)
    )
    out["natural_ligands"] = out.join(
        nat.groupby(["ecNumber", "organism"])["ligandStructureId"].apply(
            frozenset
        ),
        on=["ec4", "organism"],
    )["ligandStructureId"].pipe(replace_nulls_with_empty_set)
    out["is_natural"] = out.apply(
        lambda row: row["ligand_structure_id"] in row["natural_ligands"], axis=1
    )
    out["ph"] = out["commentary"].str.extract(PH_REGEX)[0]
    out["mols"] = out["commentary"].str.extract(MOL_REGEX)[0]
    out["temperature"] = out["commentary"].str.extract(TEMP_REGEX)[0]
    for ec in [1, 2, 3]:
        out["ec" + str(ec)] = [".".join(s.split(".")[:ec]) for s in out["ec4"]]
    out["log_km"] = np.log(out["km"])
    out["sub_type"] = (
        out["substrate"].where(lambda s: s.isin(COFACTORS)).fillna("other")
    )
    out["biology"] = out[BIOLOGY_FCTS].astype(str).apply("|".join, axis=1)
    return out


def filter_reports(r: pd.DataFrame, natural_only: bool) -> pd.Series:
    """Get a boolean series indicating whether to keep each report.

    :param r: DataFrame of reports. Note that dtypes of the temperature and ph
    columns must be float.

    :param natural_only: Whether or not to exclude reports with non-natural
    substrates.

    """
    base = (
        r[NON_NULL_COLS].notnull().all(axis=1).astype(bool)
        & r["km"].ge(0)
        & ~r["ligand_structure_id"].eq(0)
        & r["organism"].isin(ORGANISMS_TO_INCLUDE)
        & ~r["temperature"].ge(50)
        & ~r["temperature"].le(5)
        & ~r["ph"].ge(9)
        & ~r["ph"].le(4)
    )
    if natural_only:
        base = base & r["is_natural"]
    return base


def process_temperature_column(t: pd.Series) -> pd.Series:
    """Convert a series of string temperatures to floats.

    If the reported temperature is e.g '1-2', take the mean (so e.g. 1.5).

    :param t: A pandas Series of strings

    """
    return t.str.split("-").explode().astype(float).groupby(level=0).mean()


def prepare_data(pp: pd.DataFrame, k: int) -> PrepareDataOutput:

    """Get a dataframe of literature/biology groups.

    Uses the Borger, Liebermeister and Klipp framework.

    :param pp: A dataframe of preprocessed reports

    :param natural_only: A bool indicating whether to exclude measurements of
    non-natural substrates

    :param k: number of train/test splits

    """
    r = pp.copy()

    # correct dtypes if necessary
    r["temperature"] = process_temperature_column(r["temperature"])
    r["ph"] = r["ph"].astype(float)
    r["mols"] = r["mols"].astype(float)
    r["km"] = r["km"].astype(float)

    r["ec_sub"] = r["ec4"].astype(str).str.cat(r["substrate"], sep="|")
    r["org_sub"] = r["organism"].str.cat(r["substrate"], sep="|")

    # filter
    cond = filter_reports(r, natural_only=True)
    r = r.loc[cond]

    fcts = BIOLOGY_FCTS + ["ec_sub", "org_sub", "literature", "biology"]
    # group
    g = r.groupby(["biology", "literature"])
    lits = pd.DataFrame(
        {
            **{c: g[c].first() for c in fcts},
            **{"y": g["log_km"].mean(), "n": g.size(), "sd": g["log_km"].std()},
        }
    ).reset_index(drop=True)
    for fct in fcts:
        lits[fct + "_stan"] = pd.factorize(lits[fct])[0] + 1
    stan_input_base = {
        "N_bio": lits["biology"].nunique(),
        "N_sub": lits["substrate"].nunique(),
        "N_ec_sub": lits["ec_sub"].nunique(),
        "N_org_sub": lits["org_sub"].nunique(),
        "sub": lits.groupby("biology")["substrate_stan"].first(),
        "ec_sub": lits.groupby("biology")["ec_sub_stan"].first(),
        "org_sub": lits.groupby("biology")["org_sub_stan"].first(),
    }
    stan_input_posterior, stan_input_prior = (
        listify_dict(
            {
                **stan_input_base,
                **{
                    "N_train": len(lits),
                    "N_test": len(lits),
                    "biology_train": lits["biology_stan"],
                    "biology_test": lits["biology_stan"],
                    "y_train": lits["y"],
                    "y_test": lits["y"],
                },
                **{"likelihood": int(likelihood)},
            }
        )
        for likelihood in [1, 0]
    )
    splits = list(KFold(k, shuffle=True).split(lits))
    stan_inputs_cv = list(
        listify_dict(
            {
                **stan_input_base,
                **{
                    "N_train": len(train_ix),
                    "N_test": len(test_ix),
                    "biology_train": lits.loc[train_ix, "biology_stan"],
                    "biology_test": lits.loc[test_ix, "biology_stan"],
                    "y_train": lits.loc[train_ix, "y"],
                    "y_test": lits.loc[test_ix, "y"],
                },
                **{"likelihood": int(1)},
            }
        )
        for train_ix, test_ix in splits
    )
    coords = {c: pd.factorize(lits[c])[1].tolist() for c in fcts}
    dims = {
        "a_sub": ["substrate"],
        "a_ec_sub": ["ec_sub"],
        "a_org_sub": ["org_sub"],
        "log_km": ["biology"],
    }
    return PrepareDataOutput(
        stan_input_prior=stan_input_prior,
        stan_input_posterior=stan_input_posterior,
        stan_inputs_cv=stan_inputs_cv,
        coords=coords,
        dims=dims,
        df=lits,
        splits=splits,
    )


def listify_dict(d: Dict) -> Dict:
    out = {}
    for k, v in d.items():
        if not isinstance(k, str):
            raise ValueError(f"key {str(k)} is not a string!")
        elif isinstance(v, pd.Series):
            out[k] = v.values.tolist()
        elif isinstance(v, np.ndarray):
            out[k] = v.tolist()
        elif isinstance(v, (list, int, float)):
            out[k] = v
        else:
            raise ValueError(f"value {str(v)} has wrong type!")
    return out
