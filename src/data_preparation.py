"""Provides a function prepare_data."""

import numpy as np
import pandas as pd

from .util import make_columns_lower_case

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
DEFAULT_TEMPERATURE = {
    "Escherichia coli": 25,
    "Homo sapiens": 36,
    "Saccharomyces cerevisiae": 25,
}
ORGANISMS = ["Escherichia coli", "Homo sapiens", "Saccharomyces cerevisiae"]
BRENDA_NULLS = ["more", -999]
T_REGEX = r"(\d+) ?°[Cc]"  # extract temperature from comment


def prepare_data(
    raw_km_measurements: pd.DataFrame, natural_substrates: pd.DataFrame
) -> pd.DataFrame:
    """Takes in raw data, returns prepared data.

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
    out["temperature"] = out["commentary"].str.extract(T_REGEX)[0].astype(float)
    out["default_temperature"] = out["organism"].map(DEFAULT_TEMPERATURE)
    out["temperature_imputed"] = np.where(
        out["temperature"].notnull(), out["temperature"], out["default_temperature"]
    )
    out["temperature_change"] = (
        out["temperature_imputed"] - out["default_temperature"]
    ).abs()
    out["ec3"] = [".".join(ecs.split(".")[:3]) for ecs in out["ec4"]]
    out["ec2"] = [".".join(ecs.split(".")[:2]) for ecs in out["ec4"]]
    out["log_km"] = np.log(out["km"])
    return out


def prepare_data_natural_substrates_only(
    raw_km_measurements: pd.DataFrame, natural_substrates: pd.DataFrame
) -> pd.DataFrame:
    all = prepare_data(raw_km_measurements, natural_substrates)
    return all.loc[lambda df: df["is_natural"]].reset_index(drop=True)
