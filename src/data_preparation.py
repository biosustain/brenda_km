"""Provides a function prepare_data."""

import numpy as np
import pandas as pd
from typing import Dict, Any, Callable
import os
from dataclasses import dataclass

from src.util import make_columns_lower_case, get_99_pct_params_n, get_99_pct_params_ln

ORGANISMS_TO_INCLUDE = ["Escherichia coli", "Homo sapiens", "Saccharomyces cerevisiae"]
NEW_COLNAMES = {
    "ecNumber": "ec4",
    "kmValue": "km",
    "ligandStructureId": "ligand_structure_id",
}
NON_NULL_COLS = ["ec4", "km", "organism", "substrate"]
EXTRA_NULL_VALUES = ["more", -999]
NUMBER_REGEX = r"\d*\.?\d+"
TEMP_REGEX = fr"({NUMBER_REGEX}-{NUMBER_REGEX}|{NUMBER_REGEX}) ?(&ordm;|&deg;)[Cc]"
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


@dataclass
class PrepareDataOutput:
    stan_input: Dict[str, Any]
    coords: Dict[str, Any]
    dims: Dict[str, Any]
    df: pd.DataFrame


@dataclass
class PrepareDataInput:
    prepare_func: Callable[[pd.DataFrame, pd.DataFrame, bool, bool], PrepareDataOutput]
    pp: pd.DataFrame
    priors: pd.DataFrame
    likelihood: bool
    natural_only: bool
    name: str


def replace_nulls_with_empty_set(s: pd.Series) -> pd.Series:
    """Work around not being able to pass sets to pd.Series.fillna."""
    return pd.Series(np.where(s.notnull(), s, frozenset()), index=s.index)


def preprocess(km: pd.DataFrame, nat: pd.DataFrame) -> pd.DataFrame:
    """Add extra columns to the raw data and tidy some names.

    No deleting!

    """
    out = (
        km.copy()
        .rename(columns=NEW_COLNAMES)
        .replace(EXTRA_NULL_VALUES, np.nan)
        .pipe(make_columns_lower_case)
    )
    out["natural_ligands"] = out.join(
        nat.groupby(["ecNumber", "organism"])["ligandStructureId"].apply(frozenset),
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
    out["substrate_type"] = (
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
        r[NON_NULL_COLS].notnull().all(axis=1)
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


def get_prior_dict(prior_df) -> dict:
    """Get a stan-inputtable dictionary from a priors csv path."""
    dist_to_pct_func = {
        "normal": get_99_pct_params_n,
        "lognormal": get_99_pct_params_ln,
    }
    out = {}
    for _, row in prior_df.iterrows():
        if row["distribution"] not in dist_to_pct_func.keys():
            raise ValueError(
                f"Distribution {row['distribution']} not available. "
                + f"Use one of {list(dist_to_pct_func.keys())}."
            )
        pct_func = dist_to_pct_func[row["distribution"]]
        mu, sigma = pct_func(row["pct_1"], row["pct_99"])
        out["prior_" + row["parameter"]] = [mu, sigma]
    return out


def lump_biologies(df: pd.DataFrame, n: int = 4) -> pd.Series:
    """Put biologies together so that there are none with fewer than n rows.

    If there are fewer than n rows for a given biology, the "biology" column is
    replaced by a coarser category. The fallback order is follows:

      ["ec4", "organism", "substrate_type"],
      ["ec4", "organism"],
      ["ec4"],
      ["ec3"],

    """
    out = df["biology"].copy()
    print(
        f"Starting with {out.nunique()} biologies,"
        f" lumping those with fewer than {n} occurences..."
    )
    n_sparse = out.groupby(out).size().lt(n).sum()
    for cols in [
        ["ec4", "organism", "substrate_type"],
        ["ec4", "organism"],
        ["ec4"],
        ["ec3"],
    ]:
        print(f"\n...lumping {n_sparse} sparse biologies based on {', '.join(cols)}.")
        out = pd.Series(
            np.where(
                df.groupby(out)["y"].transform("size").ge(n),
                out,
                df[cols].astype(str).apply("|".join, axis=1) + "|other",
            ),
            index=out.index,
        )
        n_sparse = out.groupby(out).size().lt(n).sum()
        print(f"...{out.nunique()} biologies remaining of which {n_sparse} are sparse")
    return out


def process_temperature_column(t: pd.Series) -> pd.Series:
    """Convert a series of string temperatures to floats.

    If the reported temperature is e.g '1-2', take the mean (so e.g. 1.5).

    :param t: A pandas Series of strings

    """
    return t.str.split("-").explode().astype(float).groupby(level=0).mean()


def get_lits(pp: pd.DataFrame, natural_only: bool) -> pd.DataFrame:
    """Get a dataframe of literature/biology groups.

    :param pp: A dataframe of preprocessed reports

    :param natural_only: A bool indicating whether to exclude measurements of
    non-natural substrates

    """
    input_fcts = BIOLOGY_FCTS + [
        "substrate",
        "organism",
        "biology",
        "literature",
        "ec4",
        "ec3",
        "ec2",
        "ec1",
        "is_natural",
        "substrate_type",
    ]
    output_fcts = input_fcts + ["biology_lump"]

    r = pp.copy()

    # correct dtypes if necessary
    r["temperature"] = process_temperature_column(r["temperature"])
    r["ph"] = r["ph"].astype(float)
    r["mols"] = r["mols"].astype(float)
    r["km"] = r["km"].astype(float)

    # filter
    cond = filter_reports(r, natural_only=natural_only)
    r = r.loc[cond]

    # group
    g = r.groupby(["biology", "literature"])
    lits = pd.DataFrame(
        {
            **{c: g[c].first() for c in input_fcts},
            **{"y": g["log_km"].mean(), "n": g.size(), "sd": g["log_km"].std()},
        }
    ).reset_index(drop=True)
    lits["biology_lump"] = lump_biologies(lits, n=2)

    # second filter: drop rows whose lumped biologies have too few observations
    lits = lits.loc[
        lambda df: df.groupby("biology_lump")["y"].transform("size").ge(2),
    ]

    # add 1-indexed factor columns for Stan
    for fct in output_fcts:
        lits[fct + "_stan"] = pd.factorize(lits[fct])[0] + 1

    return lits


def prepare_data_lit(
    pp: pd.DataFrame, priors: pd.DataFrame, likelihood: bool, natural_only: bool
) -> PrepareDataOutput:
    """Prepare data at the level of study x org x substrate x ec number.

    :param pp: A dataframe of preprocessed reports

    :param priors: A dataframe of priors

    :param likelihood: A bool corresponding to the (integer-valued)
    "likelihood" field in the Stan input.

    :param natural_only: A bool indicating whether to exclude measurements of
    non-natural substrates

    """
    lits = get_lits(pp, natural_only)
    fcts = [c for c in lits.columns if c + "_stan" in lits.columns]
    prior_dict = get_prior_dict(priors)
    stan_input_no_priors = {
        "N": len(lits),
        "N_biology": lits["biology_lump"].nunique(),
        "N_cat": lits["literature"].nunique(),
        "biology": lits["biology_lump_stan"].values,
        "lit": lits["literature_stan"].values,
        "N_natural": lits["is_natural"].sum().astype(int),
        "y": lits["y"].values,
        "N_substrate_type": lits["substrate_type"].nunique(),
        "N_ec4": lits["ec4"].nunique(),
        "N_ec3": lits["ec3"].nunique(),
        "N_ec2": lits["ec2"].nunique(),
        "N_ec1": lits["ec1"].nunique(),
        "ec1": lits.groupby("ec2")["ec1_stan"].first().values,
        "ec2": lits.groupby("ec3")["ec2_stan"].first().values,
        "ec3": lits.groupby("ec4")["ec3_stan"].first().values,
        "ec4": lits.groupby("biology_lump")["ec4_stan"].first().values,
        "substrate_type": lits.groupby("biology_lump")["substrate_type_stan"]
        .first()
        .values,
        "is_natural": lits["is_natural"].astype(int).values,
        "likelihood": int(likelihood),
    }
    stan_input = {**stan_input_no_priors, **prior_dict}
    coords = {c: pd.factorize(lits[c])[1].tolist() for c in fcts}
    dims = {
        "a_ec2": ["ec2"],
        "a_sub": ["substrate_type"],
        "a_ec3": ["ec3"],
        "a_ec4": ["ec4"],
        "a_biology": ["biology_lump"],
        "tau_ec4": ["ec3"],
        "tau_ec3": ["ec2"],
        "a_ec2_tau_log_km": ["ec2"],
        "a_ec3_tau_log_km": ["ec3"],
        "a_ec4_tau_log_km": ["ec4"],
        "yhat": ["cat"],
        "log_km": ["cat"],
    }
    return PrepareDataOutput(stan_input, coords, dims, lits)
