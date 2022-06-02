"""Provides functions prepare_data_x and dataclass PrepareDataOutput."""

from dataclasses import dataclass, field
from functools import partial
from typing import Any, Callable, Dict, List, Union

import numpy as np
import pandas as pd
from sklearn.model_selection import KFold

from .util import make_columns_lower_case  # type: ignore

NUMBER_REGEX = r"\d*\.?\d+"
TEMP_REGEX = (
    rf"({NUMBER_REGEX}-{NUMBER_REGEX}|{NUMBER_REGEX}) ?(&ordm;|&deg;)[Cc]"
)
PH_REGEX = rf"[pP][hH] ({NUMBER_REGEX})"
MOL_REGEX = rf".* ({NUMBER_REGEX}) ?[mM]"
COFACTORS = [
    "ATP",
    "NADH",
    "NAD+",
    "NADPH",
    "O2",
    "NADP+",
    "ADP",
]
DIMS = {
    "a_substrate": ["substrate"],
    "a_ec4_sub": ["ec4_sub"],
    "a_enz_sub": ["enz_sub"],
    "a_org_sub": ["org_sub"],
    "log_km": ["biology"],
    "llik": ["ix_test"],
    "yrep": ["ix_test"],
}
TEMPERATURE_RANGE = 10.0, 45.0
PH_RANGE = 5.0, 9.0
HARDCODED_NATURAL_SUBSTRATES = {
    "1.1.1.49": [391, 11111],  # 6-phosphonogluconate
    "3.1.1.31": [4217],  # 6-phospho-D-glucono-1,5-lactone
}

# types
StanDict = Dict[str, Union[float, int, List[float], List[int]]]
CoordDict = Dict[str, List[str]]


@dataclass
class PrepareDataOutput:
    """Return value of a prepare_data function."""

    name: str
    coords: Dict[str, Any]
    reports: pd.DataFrame
    lits: pd.DataFrame
    dims: Dict[str, Any]
    number_of_cv_folds: int
    standict_function: Callable
    biology_maps: Dict[str, List[str]]
    standict_prior: StanDict = field(init=False)
    standict_posterior: StanDict = field(init=False)
    standicts_cv: List[StanDict] = field(init=False)

    def __post_init__(self):
        """Add stan input dictionaries."""
        ix_all = list(range(len(self.lits)))
        splits = []
        for train, test in KFold(self.number_of_cv_folds, shuffle=True).split(
            self.lits
        ):
            assert isinstance(train, np.ndarray)
            assert isinstance(test, np.ndarray)
            splits.append([list(train), list(test)])
        get_standict_xv = partial(
            self.standict_function,
            lits=self.lits,
            coords=self.coords,
            likelihood=True,
        )
        get_standict_main = partial(
            self.standict_function,
            lits=self.lits,
            coords=self.coords,
            train_ix=ix_all,
            test_ix=ix_all,
        )
        self.standict_prior, self.standict_posterior = (
            get_standict_main(likelihood=likelihood)
            for likelihood in (False, True)
        )
        self.standicts_cv = [
            get_standict_xv(train_ix=train_ix, test_ix=test_ix)
            for train_ix, test_ix in splits
        ]


def process_temperature_column(t: pd.Series) -> pd.Series:
    """Convert a series of string temperatures to floats.

    If the reported temperature is e.g '1-2', take the mean (so e.g. 1.5).

    :param t: A pandas Series of strings

    """
    return t.str.split("-").explode().astype(float).groupby(level=0).mean()


def correct_brenda_dtypes(r: pd.DataFrame):
    """Make sure the columns have the right dtypes.

    :param r: dataframe of reports
    """
    df_out = r.copy()
    float_cols = ["ph", "mols", "temperature", "km", "kcat"]
    for col in float_cols:
        if col in r.columns:
            df_out[col] = r[col].astype(float)
    return df_out


def add_columns_to_brenda_reports(
    r: pd.DataFrame, nat: pd.DataFrame
) -> pd.DataFrame:
    """Add new columns to a table of reports.

    :param r: Dataframe of reports
    """
    ec4_to_natural_substrates = (
        nat.groupby("ec4")["ligand_structure_id"].apply(list).to_dict()
    )
    out = r.copy()
    out["is_natural"] = out.apply(
        lambda row: row["ligand_structure_id"]
        in ec4_to_natural_substrates[row["ec4"]]
        if row["ec4"] in ec4_to_natural_substrates.keys() else False,
        axis=1,
    )
    out["ph"] = out["commentary"].str.extract(PH_REGEX)[0]
    out["mols"] = out["commentary"].str.extract(MOL_REGEX)[0]
    out["temperature"] = process_temperature_column(
        out["commentary"].str.extract(TEMP_REGEX)[0]
    )
    for ec in [1, 2, 3]:
        out["ec" + str(ec)] = [".".join(s.split(".")[:ec]) for s in out["ec4"]]
    return out


def preprocess_brenda_reports(
    raw_reports: pd.DataFrame, natural_substrates: pd.DataFrame
) -> pd.DataFrame:
    """Correct names, nulls and dtypes of Brenda reports table."""
    return (
        raw_reports
        .replace(["more", -999], np.nan)
        .rename(
            columns={
                "ecNumber": "ec4",
                "kmValue": "km",
                "turnoverNumber": "kcat",
                "ligandStructureId": "ligand_structure_id",
            }
        )
        .pipe(make_columns_lower_case)
        .pipe(add_columns_to_brenda_reports, natural_substrates)
        .pipe(correct_brenda_dtypes)
    )


def prepare_data_brenda(
    name: str,
    raw_reports: pd.DataFrame,
    natural_substrates: pd.DataFrame,
    number_of_cv_folds,
) -> PrepareDataOutput:
    """Get PrepareDataOutput for brenda."""
    reports = preprocess_brenda_reports(raw_reports, natural_substrates)
    biology_cols = ["organism", "ec4", "substrate"]
    lit_cols = biology_cols + ["literature"]
    cond = (
        reports[biology_cols].notnull().all(axis=1).astype(bool)
        & reports["km"].notnull()
        & reports["km"].ge(0)
        & ~reports["ligand_structure_id"].eq(0)
        & (
            reports["temperature"].isnull()
            | reports["temperature"].astype(float).between(*TEMPERATURE_RANGE)
        )
        & (
            reports["ph"].isnull()
            | reports["ph"].astype(float).between(*PH_RANGE)
        )
        & reports["is_natural"]
    )
    reports["y"] = np.log(reports["km"].values)  # type: ignore
    reports["biology"] = (
        reports[biology_cols].fillna("").apply("|".join, axis=1)
    )
    reports = reports.loc[cond].copy()
    lits = (
        reports.groupby(lit_cols)
        .agg({"y": "median", "biology": "first"})
        .reset_index()
        .loc[lambda df: df.groupby("organism")["y"].transform("size") > 50]
        .reset_index()
    )
    coords = {}
    lits["literature"] = lits["literature"].astype(str)
    lits["biology"] = lits[biology_cols].apply("|".join, axis=1)
    lits["ec4_sub"] = lits["ec4"].str.cat(lits["substrate"], sep="|")
    lits["org_sub"] = lits["organism"].str.cat(lits["substrate"], sep="|")
    fcts = biology_cols + ["ec4_sub", "org_sub", "literature", "biology"]
    fcts_with_unknowns = ["substrate", "ec4_sub", "org_sub"]
    for fct in fcts:
        if fct in fcts_with_unknowns:
            lits[fct + "_stan"] = pd.factorize(lits[fct])[0] + 2
            coords[fct] = ["unknown"] + pd.factorize(lits[fct])[1].tolist()
        else:
            lits[fct + "_stan"] = pd.factorize(lits[fct])[0] + 1
            coords[fct] = pd.factorize(lits[fct])[1].tolist()
    biology_maps = {
        col: lits.groupby("biology")[col].first().tolist()
        for col in biology_cols
    }
    return PrepareDataOutput(
        name=name,
        lits=lits,
        coords=coords,
        reports=reports,
        dims=DIMS,
        number_of_cv_folds=number_of_cv_folds,
        standict_function=get_standict_brenda,
        biology_maps=biology_maps,
    )


def get_standict_brenda(
    lits: pd.DataFrame,
    coords: CoordDict,
    likelihood: bool,
    train_ix: List[int],
    test_ix: List[int],
) -> StanDict:
    """Get a Stan input for the brenda data.

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
            "N_ec4_sub": len(coords["ec4_sub"]),
            "N_org_sub": len(coords["org_sub"]),
            "substrate": lits.groupby("biology")["substrate_stan"].first(),
            "ec4_sub": lits.groupby("biology")["ec4_sub_stan"].first(),
            "org_sub": lits.groupby("biology")["org_sub_stan"].first(),
            "N_train": len(train_ix),
            "N_test": len(test_ix),
            "N": len(list(set(train_ix + test_ix))),
            "biology_train": lits.loc[train_ix, "biology_stan"],
            "biology_test": lits.loc[test_ix, "biology_stan"],
            "ix_train": [i + 1 for i in train_ix],
            "ix_test": [i + 1 for i in test_ix],
            "y": lits["y"],
            "likelihood": int(likelihood),
        }
    )


def get_standict_sabio(
    lits: pd.DataFrame,
    coords: CoordDict,
    likelihood: bool,
    train_ix: List[int],
    test_ix: List[int],
) -> StanDict:
    """Get a Stan input for the sabio data.

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
            "N_ec4_sub": len(coords["ec4_sub"]),
            "N_org_sub": len(coords["org_sub"]),
            "N_enz_sub": len(coords["enz_sub"]),
            "substrate": lits.groupby("biology")["substrate_stan"].first(),
            "ec4_sub": lits.groupby("biology")["ec4_sub_stan"].first(),
            "org_sub": lits.groupby("biology")["org_sub_stan"].first(),
            "enz_sub": lits.groupby("biology")["enz_sub_stan"].first(),
            "N_train": len(train_ix),
            "N_test": len(test_ix),
            "N": len(list(set(train_ix + test_ix))),
            "biology_train": lits.loc[train_ix, "biology_stan"],
            "biology_test": lits.loc[test_ix, "biology_stan"],
            "ix_train": [i + 1 for i in train_ix],
            "ix_test": [i + 1 for i in test_ix],
            "y": lits["y"],
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
            out[k] = v.to_list()
        elif isinstance(v, np.ndarray):
            out[k] = v.tolist()
        elif isinstance(v, (list, int, float)):
            out[k] = v
        else:
            raise ValueError(f"value {str(v)} has wrong type!")
    return out


def prepare_hmdb_concs(raw: pd.DataFrame) -> pd.DataFrame:
    """Process raw hmdb table."""
    concentration_regex = rf"^({NUMBER_REGEX})"
    conc = (
        raw["concentration_value"]
        .str.extract(concentration_regex)[0]
        .astype(float)
    )
    cond = (
        raw["concentration_units"].eq("uM")
        & raw["subject_age"].str.contains("Adult")
        & raw["subject_condition"].eq("Normal")
        & conc.notnull()
    )
    return raw.loc[cond].copy().assign(concentration_uM=conc)


def prepare_sabio_concentrations(raw: pd.DataFrame) -> pd.DataFrame:
    """Process sabio concentrations table."""
    cond = (
        raw["parameter.type"].eq("concentration")
        & raw["parameter.startValue"].notnull()
        & raw["parameter.startValue"].gt(0)
        & ~raw["parameter.associatedSpecies"].eq("Enzyme")
        & raw["parameter.unit"].eq("M")
    )
    out = raw.loc[cond].copy()
    out["concentration_mM"] = np.exp(
        np.log(
            out[["parameter.startValue", "parameter.endValue"]].multiply(1000)
        ).mean(axis=1)
    )
    return out


def prepare_data_sabio(
    name: str,
    raw_reports: pd.DataFrame,
    number_of_cv_folds,
) -> PrepareDataOutput:
    """Get prepared data for the sabio dataset."""
    assert isinstance(raw_reports, pd.DataFrame)
    reports = raw_reports.rename(
        columns={
            "Substrate": "reaction_substrates",
            "EnzymeType": "enzyme_type",
            "PubMedID": "literature",
            "Organism": "organism",
            "UniprotID": "uniprot_id",
            "ECNumber": "ec4",
            "parameter.type": "parameter_type",
            "parameter.associatedSpecies": "substrate",
            "parameter.startValue": "start_value",
            "parameter.endValue": "end_value",
            "parameter.standardDeviation": "sd",
            "parameter.unit": "unit",
            "Temperature": "temperature",
            "pH": "ph",
        }
    ).replace("-", np.nan)
    biology_cols = ["organism", "ec4", "uniprot_id", "substrate"]
    lit_cols = biology_cols + ["literature"]
    cond = (
        reports["parameter_type"].eq("Km")
        & reports["enzyme_type"].str.contains("wildtype")
        & reports["start_value"].notnull()
        & reports["start_value"].gt(0)
        & reports["start_value"].lt(2000)
        & reports["unit"].eq("M")
        & (
            reports["temperature"].isnull()
            | reports["temperature"].astype(float).between(*TEMPERATURE_RANGE)
        )
        & (
            reports["ph"].isnull()
            | reports["ph"].astype(float).between(*PH_RANGE)
        )
        & reports["literature"].notnull()
    )
    reports = reports.loc[cond].copy()
    reports["y"] = np.log(
        reports[["start_value", "end_value"]]
        # multiply by 1000 to convert from M to mM
        .multiply(1000)
    ).mean(axis=1)
    reports["uniprot_id"] = np.where(
        reports["uniprot_id"].str.contains(" "), np.nan, reports["uniprot_id"]
    )
    reports["biology"] = (
        reports[biology_cols].fillna("").apply("|".join, axis=1)
    )
    lits = (
        reports.loc[cond]
        .groupby(lit_cols, dropna=False)
        .agg(
            {"y": "median", "biology": "first", "reaction_substrates": "first"}
        )
        .reset_index()
        .loc[lambda df: df.groupby("organism")["y"].transform("size") > 50]
        .reset_index()
    )
    lits["literature"] = lits["literature"].astype(int).astype(str)
    lits["ec4_sub"] = lits["ec4"].str.cat(lits["substrate"], sep="|")
    lits["enz_sub"] = np.where(
        lits["uniprot_id"].notnull(),
        lits["uniprot_id"].str.cat(lits["substrate"], sep="|"),
        np.nan,
    )
    lits["org_sub"] = lits["organism"].str.cat(lits["substrate"], sep="|")
    fcts = biology_cols + [
        "ec4_sub",
        "org_sub",
        "enz_sub",
        "literature",
        "biology",
    ]
    coords = {}
    fcts_with_unknowns = ["substrate", "ec4_sub", "org_sub", "enz_sub"]
    for fct in fcts:
        if fct in fcts_with_unknowns:
            lits[fct + "_stan"] = pd.factorize(lits[fct])[0] + 2
            coords[fct] = ["unknown"] + pd.factorize(lits[fct])[1].tolist()
        else:
            lits[fct + "_stan"] = pd.factorize(lits[fct])[0] + 1
            coords[fct] = pd.factorize(lits[fct])[1].tolist()
    biology_maps = {
        col: lits.groupby("biology")[col].first().tolist()
        for col in biology_cols
    }
    return PrepareDataOutput(
        name=name,
        lits=lits,
        coords=coords,
        reports=reports,
        dims=DIMS,
        number_of_cv_folds=number_of_cv_folds,
        standict_function=get_standict_sabio,
        biology_maps=biology_maps,
    )


def prepare_natural_substrates(raw: pd.DataFrame) -> pd.DataFrame:
    """Make a long table of natural substrates."""
    dtypes = {
        "ec4": "string",
        "ligand_structure_id": "int64",
    }
    out = (
        raw.loc[
            lambda df: (df["naturalReactionPartners"] != "more = ?")
            & (df["ligandStructureId"] != 0),
            ["ecNumber", "organism", "ligandStructureId"],
        ]
        .rename(
            columns={
                "ecNumber": "ec4",
                "ligandStructureId": "ligand_structure_id",
            }
        )
        .dropna(how="any")
        .astype(dtype=dtypes)[["ec4", "ligand_structure_id"]]
        .drop_duplicates()
    )
    hardcoded = (
        pd.DataFrame.from_dict(
            HARDCODED_NATURAL_SUBSTRATES, orient="index"  # type: ignore
        )
        .stack()
        .droplevel(1)
        .reset_index()
        .set_axis(out.columns, axis=1)
        .astype(dtype=dtypes)
    )
    out = pd.concat([out, hardcoded], ignore_index=True)
    out = out.drop_duplicates()
    return out
