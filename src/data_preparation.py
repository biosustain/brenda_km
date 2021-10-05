"""Provides a function prepare_data."""

import os
from dataclasses import dataclass
from typing import Any, Callable, Dict, Tuple

import numpy as np
import pandas as pd

from src.util import (
    get_99_pct_params_ln,
    get_99_pct_params_n,
    make_columns_lower_case,
)

ORGANISMS_TO_INCLUDE = [
    "Escherichia coli",
    "Homo sapiens",
    "Saccharomyces cerevisiae",
]
NEW_COLNAMES = {
    "ecNumber": "ec4",
    "kmValue": "km",
    "ligandStructureId": "ligand_structure_id",
}
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


@dataclass
class PrepareDataOutput:
    stan_input: Dict[str, Any]
    coords: Dict[str, Any]
    dims: Dict[str, Any]
    df: pd.DataFrame


@dataclass
class PrepareDataInput:
    prepare_func: Callable[
        [pd.DataFrame, pd.DataFrame, bool, bool], PrepareDataOutput
    ]
    pp: pd.DataFrame
    priors: pd.DataFrame
    likelihood: bool
    natural_only: bool
    name: str


def replace_nulls_with_empty_set(s: pd.Series) -> pd.Series:
    """Work around not being able to pass sets to pd.Series.fillna."""
    return pd.Series(np.where(s.notnull(), s, frozenset()), index=s.index)


def preprocess(km: pd.DataFrame, nat: pd.DataFrame) -> pd.DataFrame:
    """Add extra columns to the raw data and tidy some names."""
    out = (
        km.copy()
        .rename(columns=NEW_COLNAMES)
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


def lump_biologies(df: pd.DataFrame, n: int = 4) -> Tuple[pd.Series, pd.Series]:
    """Put biologies together so that there are none with fewer than n rows.

    If there are fewer than n rows for a given biology, the "biology" column is
    replaced by a coarser category. The fallback order is follows:

    1. replace substrate with "any substrate"
    2. replace organism with "any organism"
    3. replace ec4 with ec3
    3. replace ec4 with ec2
    3. replace ec4 with ec1

    """
    lump_df = df[BIOLOGY_FCTS + ["sub_type"]].copy()
    lump_df["dummy_substrate"] = "any substrate"
    lump_df["dummy_organism"] = "any organism"
    lump_df["ec4_lump"] = df["ec3"].copy()
    lump_df["ec4_lump_2"] = df["ec2"].copy()
    lump_df["ec4_lump_3"] = df["ec1"].copy()
    lump_df["lump_level"] = 1
    replacements = [
        ("substrate", lump_df["dummy_substrate"].copy()),
        ("organism", lump_df["dummy_organism"].copy()),
        ("ec4", lump_df["ec4_lump"].copy()),
        ("ec4", lump_df["ec4_lump_2"].copy()),
        ("ec4", lump_df["ec4_lump_3"].copy()),
    ]
    for i, (original_col, replacement) in enumerate(replacements):
        replace = (
            lump_df.groupby(BIOLOGY_FCTS)["substrate"].transform("size").lt(n)
        )
        print(
            f"Replacing {original_col} with {replacement.name}"
            f" in {replace.sum()} cases."
        )
        lump_df[original_col] = np.where(
            replace, replacement, lump_df[original_col]
        )
        lump_df.loc[replace, "lump_level"] = i + 2
    n_sparse = lump_df.groupby(BIOLOGY_FCTS).size().lt(n).sum()
    print(f"{n_sparse} sparse biologies remain after lumping.")
    bio_lumps = pd.Series(
        lump_df[BIOLOGY_FCTS].apply(lambda row: "|".join(row.values), axis=1)
    )
    return bio_lumps, lump_df["lump_level"]


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
        "sub_type",
    ]
    output_fcts = input_fcts + ["bio_lump"]

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
    lits["bio_lump"], lits["lump_level"] = lump_biologies(lits, n=2)

    # second filter: drop rows whose lumped biologies have too few observations
    lits = lits.loc[
        lambda df: df.groupby("bio_lump")["y"].transform("size").ge(2),
    ]

    # add 1-indexed factor columns for Stan
    for fct in output_fcts:
        lits[fct + "_stan"] = pd.factorize(lits[fct])[0] + 1

    return lits


def get_lits_blk(pp: pd.DataFrame, natural_only: bool) -> pd.DataFrame:
    """Get a dataframe of literature/biology groups.

    Uses the Borger, Liebermeister and Klipp framework.

    :param pp: A dataframe of preprocessed reports

    :param natural_only: A bool indicating whether to exclude measurements of
    non-natural substrates

    """
    fcts = BIOLOGY_FCTS + [
        "substrate",
        "organism",
        "biology",
        "ec_sub",
        "org_sub",
        "literature",
        "is_natural",
    ]

    r = pp.copy()

    # correct dtypes if necessary
    r["temperature"] = process_temperature_column(r["temperature"])
    r["ph"] = r["ph"].astype(float)
    r["mols"] = r["mols"].astype(float)
    r["km"] = r["km"].astype(float)

    r["ec_sub"] = r["ec4"].astype(str).str.cat(r["substrate"], sep="|")
    r["org_sub"] = r["organism"].str.cat(r["substrate"], sep="|")

    # filter
    cond = filter_reports(r, natural_only=natural_only)
    r = r.loc[cond]

    # group
    g = r.groupby(["biology", "literature"])
    lits = pd.DataFrame(
        {
            **{c: g[c].first() for c in fcts},
            **{"y": g["log_km"].mean(), "n": g.size(), "sd": g["log_km"].std()},
        }
    ).reset_index(drop=True)

    # add 1-indexed factor columns for Stan
    for fct in fcts:
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
        "N_biology": lits["bio_lump"].nunique(),
        "biology": lits["bio_lump_stan"].values,
        "lit": lits["literature_stan"].values,
        "N_natural": lits["is_natural"].sum().astype(int),
        "N_lump_level": lits["lump_level"].nunique(),
        "y": lits["y"].values,
        "N_sub_type": lits["sub_type"].nunique(),
        "N_ec4": lits["ec4"].nunique(),
        "N_ec3": lits["ec3"].nunique(),
        "N_ec2": lits["ec2"].nunique(),
        "N_ec1": lits["ec1"].nunique(),
        "ec1": lits.groupby("ec2")["ec1_stan"].first().values,
        "ec2": lits.groupby("ec3")["ec2_stan"].first().values,
        "ec3": lits.groupby("ec4")["ec3_stan"].first().values,
        "ec4": lits.groupby("bio_lump")["ec4_stan"].first().values,
        "sub_type": lits.groupby("bio_lump")["sub_type_stan"].first().values,
        "lump_level": lits.groupby("bio_lump")["lump_level"].first().values,
        "is_natural": lits["is_natural"].astype(int).values,
        "likelihood": int(likelihood),
    }
    stan_input = {**stan_input_no_priors, **prior_dict}
    coords = {c: pd.factorize(lits[c])[1].tolist() for c in fcts}
    dims = {
        "a_ec2": ["ec2"],
        "a_sub": ["sub_type"],
        "a_ec3": ["ec3"],
        "a_ec4": ["ec4"],
        "a_biology": ["bio_lump"],
        "tau_ec4": ["ec3"],
        "a_ec2_tau_log_km": ["ec2"],
        "a_ec3_tau_log_km": ["ec3"],
        "a_ec4_tau_log_km": ["ec4"],
        "yhat": ["bio_lump"],
        "log_km": ["bio_lump"],
    }
    return PrepareDataOutput(stan_input, coords, dims, lits)


def prepare_data_blk(
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
    lits = get_lits_blk(pp, natural_only)
    fcts = [c for c in lits.columns if c + "_stan" in lits.columns]
    stan_input = {
        "N": len(lits),
        "N_biology": lits["biology"].nunique(),
        "biology": lits["biology_stan"].values,
        "N_natural": lits["is_natural"].sum().astype(int),
        "N_sub": lits["substrate"].nunique(),
        "N_ec_sub": lits["ec_sub"].nunique(),
        "N_org_sub": lits["org_sub"].nunique(),
        "substrate": lits.groupby("biology")["substrate_stan"].first().values,
        "ec_sub": lits.groupby("biology")["ec_sub_stan"].first().values,
        "org_sub": lits.groupby("biology")["org_sub_stan"].first().values,
        "y": lits["y"].values,
        "is_natural": lits["is_natural"].astype(int).values,
        "likelihood": int(likelihood),
    }
    coords = {c: pd.factorize(lits[c])[1].tolist() for c in fcts}
    dims = {
        "a_sub": ["substrate"],
        "a_ec_sub": ["ec_sub"],
        "a_org_sub": ["org_sub"],
        "log_km": ["biology"],
    }
    return PrepareDataOutput(stan_input, coords, dims, lits)
