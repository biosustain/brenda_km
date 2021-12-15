"""Provides a function prepare_data."""

import os
from dataclasses import dataclass
from functools import partial
from typing import Any, Dict, Iterable, List, Tuple, Union

import numpy as np
import pandas as pd
from sklearn.model_selection import KFold

from src.util import make_columns_lower_case

ORGANISMS_TO_INCLUDE = [
    "Escherichia coli",
    "Homo sapiens",
    "Saccharomyces cerevisiae",
]
BIOLOGY_FCTS = ["ec4", "organism", "substrate"]
LIT_FCTS = BIOLOGY_FCTS + ["ec_sub", "org_sub", "literature", "biology"]
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
DIMS = {
    "a_substrate": ["substrate"],
    "a_ec_sub": ["ec_sub"],
    "a_org_sub": ["org_sub"],
    "log_km": ["biology"],
}
RENAMING_DICT = {
    "ecNumber": "ec4",
    "kmValue": "km",
    "turnoverNumber": "kcat",
    "ligandStructureId": "ligand_structure_id",
}

THIS_FILE = os.path.dirname(os.path.abspath(__file__))

# types
StanDict = Dict[str, Union[float, int, List[float], List[int]]]
CoordDict = Dict[str, List[str]]


@dataclass
class PrepareDataOutput:
    name: str
    standict_prior: StanDict
    standict_posterior: StanDict
    standicts_cv: List[StanDict]
    coords: Dict[str, Any]
    dims: Dict[str, Any]
    reports: pd.DataFrame
    df: pd.DataFrame
    splits: Iterable[Tuple]


def replace_nulls_with_empty_set(s: pd.Series) -> pd.Series:
    """Work around not being able to pass sets to pd.Series.fillna."""
    return pd.Series(np.where(s.notnull(), s, frozenset()), index=s.index)


def filter_reports(
    r: pd.DataFrame, natural_only: bool, response_col: str
) -> pd.Series:
    """Get a boolean series indicating whether to keep each report.

    :param r: DataFrame of reports. Note that dtypes of the temperature and ph
    columns must be float.

    :param natural_only: Whether or not to exclude reports with non-natural
    substrates.

    :param response_col: The response variable, probably "km" or "kcat"

    """
    base = (
        r[BIOLOGY_FCTS].notnull().all(axis=1).astype(bool)
        & r[response_col].notnull()
        & r[response_col].ge(0)
        & ~r["ligand_structure_id"].eq(0)
        & ~r["temperature"].ge(50)
        & ~r["temperature"].le(5)
        & ~r["ph"].ge(9)
        & ~r["ph"].le(4)
    )
    if natural_only:
        base = base & r["is_natural"]
    organisms_to_include = (
        r.loc[base]
        .groupby(BIOLOGY_FCTS + ["literature"])["organism"]
        .first()
        .groupby("organism")
        .size()
        .loc[lambda s: s > 100]
        .index.values
    )
    return base & r["organism"].isin(organisms_to_include)


def process_temperature_column(t: pd.Series) -> pd.Series:
    """Convert a series of string temperatures to floats.

    If the reported temperature is e.g '1-2', take the mean (so e.g. 1.5).

    :param t: A pandas Series of strings

    """
    return t.str.split("-").explode().astype(float).groupby(level=0).mean()


def correct_report_dtypes(r: pd.DataFrame, response_col: str):
    """Make sure the columns have the right dtypes

    :param r: dataframe of reports
    """
    df_out = r.copy()
    float_cols = ["ph", "mols", "temperature", response_col]
    for col in float_cols:
        df_out[col] = r[col].astype(float)
    return df_out


def get_natural_ligands_col(r: pd.DataFrame, nat: pd.DataFrame):
    return r.join(
        nat.groupby(["ecNumber", "organism"])["ligandStructureId"].apply(
            frozenset
        ),
        on=["ec4", "organism"],
    )["ligandStructureId"].pipe(replace_nulls_with_empty_set)


def add_columns_to_reports(r: pd.DataFrame, nat: pd.DataFrame) -> pd.DataFrame:
    """Add new columns to a table of reports

    :param r: Dataframe of reports
    """
    out = (
        r.rename(columns=RENAMING_DICT)
        .replace(EXTRA_NULL_VALUES, np.nan)
        .pipe(make_columns_lower_case)
    )
    out["natural_ligands"] = get_natural_ligands_col(out, nat)
    out["is_natural"] = out.apply(
        lambda row: row["ligand_structure_id"] in row["natural_ligands"], axis=1
    )
    out["ph"] = out["commentary"].str.extract(PH_REGEX)[0]
    out["mols"] = out["commentary"].str.extract(MOL_REGEX)[0]
    out["temperature"] = process_temperature_column(
        out["commentary"].str.extract(TEMP_REGEX)[0]
    )
    for ec in [1, 2, 3]:
        out["ec" + str(ec)] = [".".join(s.split(".")[:ec]) for s in out["ec4"]]
    for col in ["km", "kcat"]:
        if col in out.columns:
            out[f"log_{col}"] = np.log(out[col])
    out["sub_type"] = (
        out["substrate"].where(lambda s: s.isin(COFACTORS)).fillna("other")
    )
    out["biology"] = out[BIOLOGY_FCTS].astype(str).apply("|".join, axis=1)
    out["ec_sub"] = out["ec4"].astype(str).str.cat(out["substrate"], sep="|")
    out["org_sub"] = out["organism"].str.cat(out["substrate"], sep="|")
    return out


def get_lits(reports: pd.DataFrame, response_col: str) -> pd.DataFrame:
    """get dataframe of study/km combinations ("lits")

    :param reports: dataframe of reports
    """
    g = reports.groupby(BIOLOGY_FCTS + ["literature"])
    lits = pd.DataFrame(
        {
            **{c: g[c].first() for c in LIT_FCTS},
            **{
                "y": g[response_col].median(),
                "n": g.size(),
                "sd": g[response_col].std(),
            },
        }
    ).reset_index(drop=True)
    for fct in LIT_FCTS:
        lits[fct + "_stan"] = pd.factorize(lits[fct])[0] + 1
    return lits


def get_coords(lits: pd.DataFrame) -> CoordDict:
    """Get a dictionary of Stan and arviz compatible coords

    :param lits: Dataframe of lits (see function get_lits)
    """
    coords = {c: pd.factorize(lits[c])[1].tolist() for c in LIT_FCTS}
    coords_with_unknowns = ["substrate", "ec_sub", "org_sub"]
    for coord in coords_with_unknowns:
        coords[coord] += [f"unknown {coord}"]
    return coords


def get_standict(
    lits: pd.DataFrame,
    coords: CoordDict,
    likelihood: bool,
    train_ix: List[int],
    test_ix: List[int],
) -> StanDict:
    """Get a Stan input

    :param lits: Dataframe of lits
    :param coords: Dictionary of coordinates
    :param likelihood: Whether or not to run in likelihood mode
    :param: train_ix: List of indexes of training lits
    :param: test_ix: List of indexes of test lits
    """
    return listify_dict(
        {
            "N_biology": lits["biology"].nunique(),
            "N_substrate": len(coords["substrate"]),
            "N_ec_sub": len(coords["ec_sub"]),
            "N_org_sub": len(coords["org_sub"]),
            "substrate": lits.groupby("biology")["substrate_stan"].first(),
            "ec_sub": lits.groupby("biology")["ec_sub_stan"].first(),
            "org_sub": lits.groupby("biology")["org_sub_stan"].first(),
            "N_train": len(train_ix),
            "N_test": len(test_ix),
            "biology_train": lits.loc[train_ix, "biology_stan"],
            "biology_test": lits.loc[test_ix, "biology_stan"],
            "y_train": lits.loc[train_ix, "y"],
            "y_test": lits.loc[test_ix, "y"],
            "likelihood": int(likelihood),
        }
    )


def listify_dict(d: Dict) -> StanDict:
    """Make sure a dictionary is a valid Stan input.

    :param d: input dictionary, possibly with wrong types
    """
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


def prepare_data(
    name: str,
    raw_reports: pd.DataFrame,
    natural_ligands: pd.DataFrame,
    number_of_cv_folds: int,
    response_col: str,
    natural_only: bool,
) -> PrepareDataOutput:

    """Get a dataframe of literature/biology groups.

    Uses the Borger, Liebermeister and Klipp framework.

    :param pi: A PrepareDataInput object

    """
    # get dataframe of reports
    filter_reports_for_pi = partial(
        filter_reports,
        natural_only=natural_only,
        response_col=response_col,
    )
    reports = (
        raw_reports.copy()
        .pipe(add_columns_to_reports, nat=natural_ligands)
        .pipe(correct_report_dtypes, response_col=response_col)
        .loc[filter_reports_for_pi]
    )
    lits = get_lits(reports, response_col="log_" + response_col)
    coords = get_coords(lits)
    ix_all = range(len(lits))
    splits = list(KFold(number_of_cv_folds, shuffle=True).split(lits))
    get_standict_xv = partial(
        get_standict, lits=lits, coords=coords, likelihood=True
    )
    get_standict_main = partial(
        get_standict, lits=lits, coords=coords, train_ix=ix_all, test_ix=ix_all
    )
    standict_prior, standict_posterior = (
        get_standict_main(likelihood=likelihood) for likelihood in (False, True)
    )
    standicts_cv = list(
        get_standict_xv(train_ix=train_ix, test_ix=test_ix)
        for train_ix, test_ix in splits
    )
    return PrepareDataOutput(
        name=name,
        standict_prior=standict_prior,
        standict_posterior=standict_posterior,
        standicts_cv=standicts_cv,
        reports=reports,
        coords=coords,
        dims=DIMS,
        df=lits,
        splits=splits,
    )
