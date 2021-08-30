import os
from typing import Dict, List

import pandas as pd
import toml

from src.model_configuration import ModelConfiguration
from src.util import get_99_pct_params_ln, get_99_pct_params_n

CAT_COLS = ["ec3", "ec4", "organism", "substrate", "substrate_type"]


def load_model_configuration(path) -> ModelConfiguration:
    """Load a model configuration from a path."""
    return ModelConfiguration(**toml.load(path))


def load_priors(path) -> dict:
    """Get a stan-inputtable dictionary from a priors csv path."""
    dist_to_pct_func = {
        "normal": get_99_pct_params_n,
        "lognormal": get_99_pct_params_ln,
    }
    prior_df = pd.read_csv(path)
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


def get_coords(m: pd.DataFrame, cat_cols: List[str]) -> Dict[str, List[str]]:
    cats = get_cats(m, cat_cols)
    return {
        "measurement": list(map(str, m.index.values)),
        "ec4": pd.factorize(m["ec4"])[1].tolist(),
        "ec3": pd.factorize(m["ec3"])[1].tolist(),
        "organism": pd.factorize(m["organism"])[1].tolist(),
        "cat": cats[cat_cols].astype(str).apply("-".join, axis=1).tolist(),
    }


def get_cats(m: pd.DataFrame, cat_cols: List[str]) -> pd.DataFrame:
    out = pd.DataFrame(m.groupby(cat_cols).groups.keys(), columns=cat_cols)
    out.index += 1
    for col in cat_cols:
        out[col + "_stan"] = pd.factorize(out[col])[0] + 1
    return out


def load_measurements(path, cat_cols: List[str]) -> dict:
    """Get a dataframe of measurements from a measurements csv path."""
    m = pd.read_csv(path)
    cats = get_cats(m, cat_cols)
    ix_nonzero_a_ec4 = cats.loc[
        lambda df: df.groupby("ec3")["ec4"].transform("nunique").gt(1),
        "ec4_stan",
    ].unique()
    ix_nonzero_a_org = (
        cats.reset_index()
        .loc[
            lambda df: df.groupby("ec4")["organism"].transform("nunique").gt(1),
            "index",
        ]
        .unique()
    )
    ec3_to_nonzero_ec4 = (
        cats.loc[lambda df: df["ec4_stan"].isin(ix_nonzero_a_ec4)]
        .groupby("ec4_stan")["ec3_stan"]
        .first()
    )
    return {
        "N": m.shape[0],
        "N_cat": cats.shape[0],
        "N_substrate_type": cats["substrate_type"].nunique(),
        "N_ec4": m["ec4"].nunique(),
        "N_ec3": m["ec3"].nunique(),
        "N_nonzero_a_org": len(ix_nonzero_a_org),
        "N_nonzero_a_ec4": len(ix_nonzero_a_ec4),
        "ix_nonzero_a_org": ix_nonzero_a_org.tolist(),
        "ix_nonzero_a_ec4": ix_nonzero_a_ec4.tolist(),
        "ec3_to_nonzero_ec4": ec3_to_nonzero_ec4.values,
        "ec4": cats["ec4_stan"].values,
        "ec3": cats["ec3_stan"].values,
        "substrate_type": cats["substrate_type_stan"].values,
        "is_natural": m["is_natural"].astype(int).values,
        "cat": cats.reset_index().merge(m, on=cat_cols)["index"].values,
        "y": m["log_km"].values,
    }


def load_measurements_new(path, cat_cols: List[str]) -> dict:
    """Get a dataframe of measurements from a measurements csv path."""
    m = pd.read_csv(path)
    cats = get_cats(m, cat_cols)
    ec3_orgs = cats.groupby(["ec3", "organism"]).groups.keys()
    ec3_org_codes = dict(zip(ec3_orgs, range(1, len(ec3_orgs) + 1)))
    cats["ec3_org_stan"] = cats[["ec3", "organism"]].apply(
        lambda r: ec3_org_codes[tuple(r.values)], axis=1
    )
    m["cat"] = cats.reset_index().merge(m, on=cat_cols)["index"].values
    return {
        "N": m.shape[0],
        "y": m["log_km"].values,
        "N_substrate_type": m["substrate_type"].nunique(),
        "N_cat": cats.shape[0],
        "N_enz": m["ec4"].nunique(),
        "N_ec3": m["ec3"].nunique(),
        "N_ec3_org": cats["ec3_org_stan"].nunique(),
        "enz": cats["ec4_stan"].values,
        "ec3": cats.groupby("ec4")["ec3_stan"].first().values,
        "substrate_type": cats["substrate_type_stan"].values,
        "ec3_org": cats["ec3_org_stan"].values,
        "is_natural": m.groupby("cat")["is_natural"].first().astype(int).values,
        "cat": m["cat"].values,
    }


def load_stan_input(mc: ModelConfiguration) -> dict:
    here = os.path.dirname(os.path.abspath(__file__))
    return {
        **load_priors(os.path.join(here, "..", mc.priors_file)),
        **load_measurements_new(
            os.path.join(here, "..", mc.data_file), CAT_COLS
        ),
        **{"likelihood": int(mc.likelihood)},
    }


def load_coords(path) -> dict:
    m = pd.read_csv(path)
    return get_coords(m, CAT_COLS)
