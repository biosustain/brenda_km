"""Provides a function prepare_data."""

import numpy as np
import pandas as pd
from typing import Tuple, Dict, Any
import os

from src.util import make_columns_lower_case, get_99_pct_params_n, get_99_pct_params_ln

RENAMING_DICT = {
    "ecNumber": "ec4",
    "kmValue": "km",
    "ligandStructureId": "ligand_structure_id",
}
COLS_THAT_MUST_BE_NON_NULL = [
    "ec4",
    "km",
    "organism",
    "substrate",
]
NATURAL_TEMPERATURE = {
    "Escherichia coli": 25,
    "Homo sapiens": 36,
    "Saccharomyces cerevisiae": 25,
}
ORGANISMS = ["Escherichia coli", "Homo sapiens", "Saccharomyces cerevisiae"]
BRENDA_NULLS = ["more", -999]
NUMBER_REGEX = r"\d*\.?\d+"
T_REGEX = fr"(/-{NUMBER_REGEX}-/-{NUMBER_REGEX}|/-{NUMBER_REGEX}) ?&deg;[Cc]"  # extract temperature from comment
PH_REGEX = fr"[pP][hH] ({NUMBER_REGEX})"
SUBSTRATE_TYPES = [
    "ATP",
    "NADH",
    "NAD+",
    "NADPH",
    "acetyl-CoA",
    "NADP+",
    "ADP",
]
CAT_COLS_CAT_MODEL = [
    "ec1",
    "ec2",
    "ec3",
    "ec4",
    "organism",
    "substrate",
    "substrate_type",
]
HERE = os.path.dirname(os.path.abspath(__file__))
PrepareDataOutput = Tuple[Dict[str, Any], Dict[str, Any], Dict[str, Any]]


def process_raw_data(
    raw_km_measurements: pd.DataFrame, natural_substrates: pd.DataFrame
) -> pd.DataFrame:
    """Takes in raw data, returns dataframe of all measurements with all
    information used by models.

    :param raw_data: pd.DataFrame of raw km measurements from BRENDA
    :param natural_substrates: pd.DataFrame of natural substrates from BRENDA
    ::

    """
    out = (
        raw_km_measurements.copy()
        .rename(columns=RENAMING_DICT)
        .replace(BRENDA_NULLS, np.nan)
        .pipe(make_columns_lower_case)
        .dropna(subset=COLS_THAT_MUST_BE_NON_NULL)
        .drop_duplicates()
        .loc[lambda df: (df["km"] > 0) & (df["ligand_structure_id"] != 0)]
        .loc[lambda df: df["organism"].isin(ORGANISMS)]
        .reset_index(drop=True)
    )
    out["natural_ligands"] = (
        natural_substrates.groupby(["ecNumber", "organism"])["ligandStructureId"]
        .apply(set)
        .reindex([out["ec4"], out["organism"]])
        .values
    )
    out["is_natural"] = False
    for i, r in out.iterrows():
        if type(r["natural_ligands"]) == set:
            out.loc[i, "is_natural"] = r["ligand_structure_id"] in r["natural_ligands"]
    out["dummy_col"] = 1
    out["temperature"] = (  # take the average when there's e.g. "20-23 &deg;C"
        out["commentary"]
        .str.extract(T_REGEX)[0]
        .str.split("-")
        .explode()
        .astype(float)
        .groupby(level=0)
        .mean()
    )
    out["ph"] = out["commentary"].str.extract(PH_REGEX)[0].astype(float)
    out = out.loc[  # Exclude weird experimental conditions
        lambda df: (
            ~df["temperature"].ge(50)
            & ~df["temperature"].le(5)
            & ~df["ph"].ge(9)
            & ~df["ph"].le(4)
        )
    ].copy()
    out["ec3"] = [".".join(ecs.split(".")[:3]) for ecs in out["ec4"]]
    out["ec2"] = [".".join(ecs.split(".")[:2]) for ecs in out["ec4"]]
    out["ec1"] = [".".join(ecs.split(".")[:1]) for ecs in out["ec4"]]
    out["log_km"] = np.log(out["km"])
    out["substrate_type"] = (
        out["substrate"].where(lambda s: s.isin(SUBSTRATE_TYPES)).fillna("other")
    )
    return out


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


def prepare_data_cat_model(
    measurements: pd.DataFrame, prior_df: pd.DataFrame, likelihood: bool
) -> PrepareDataOutput:
    """Get Stan/arviz data for the cat model.

    :param measuremenents: A dataframe of measurements (output of the
    prepare_data function)

    :param prior_df: A dataframe of priors

    :param likelihood: A bool corresponding to the (integer-valued)
    "likelihood" field in the Stan input.

    """
    # m = measurements.loc[lambda df: df["is_natural"]].reset_index(drop=True)
    g = (
        measurements
        # .loc[lambda df: (df["organism"].eq("Escherichia coli"))]
        .groupby(CAT_COLS_CAT_MODEL)
    )
    cats = pd.DataFrame(
        {
            "y": g["log_km"].mean(),
            "sample_size": g.size().astype(float),
            "is_natural": g["is_natural"].first().astype(float),
        }
    ).reset_index()
    for col in CAT_COLS_CAT_MODEL:
        cats[col + "_stan"] = pd.factorize(cats[col])[0] + 1
    prior_dict = get_prior_dict(prior_df)
    measurement_dict = {
        "N": len(cats),
        "y": cats["y"].values,
        "sample_size": cats["sample_size"].values,
        "N_substrate_type": cats["substrate_type"].nunique(),
        "N_ec4": cats["ec4"].nunique(),
        "N_ec3": cats["ec3"].nunique(),
        "N_ec2": cats["ec2"].nunique(),
        "N_ec1": cats["ec1"].nunique(),
        "ec1": cats.groupby("ec2")["ec1_stan"].first().values,
        "ec2": cats.groupby("ec3")["ec2_stan"].first().values,
        "ec3": cats.groupby("ec4")["ec3_stan"].first().values,
        "ec4": cats["ec4_stan"].values,
        "substrate_type": cats["substrate_type_stan"].values,
        "is_natural": cats["is_natural"].values,
    }
    config_dict = {"likelihood": int(likelihood)}
    stan_input = {**measurement_dict, **prior_dict, **config_dict}
    coords = {
        "cat": cats[CAT_COLS_CAT_MODEL].astype(str).apply("|".join, axis=1).tolist(),
        "ec4": pd.factorize(cats["ec4"])[1].tolist(),
        "ec3": pd.factorize(cats["ec3"])[1].tolist(),
        "ec2": pd.factorize(cats["ec2"])[1].tolist(),
        "substrate_type": pd.factorize(cats["substrate_type"])[1].tolist(),
    }
    dims = {
        "mu": ["substrate_type"],
        "a_ec2": ["ec2"],
        "a_ec3": ["ec3"],
        "a_ec4": ["ec4"],
        "a_cat": ["cat"],
        "tau_ec4": ["ec3"],
        "tau_ec3": ["ec2"],
        "yhat": ["cat"],
        "log_km": ["cat"],
    }
    return stan_input, coords, dims
