"""Functions for creating inputs for stan and doing things with stan outputs."""

from typing import Dict

import pandas as pd

from .util import one_encode


def get_ec3_codes(df: pd.DataFrame):
    order = df.groupby("ec3")["ec4"].nunique().sort_values(ascending=False)
    return dict(zip(order.index, range(1, len(order) + 2)))


def get_ec4_codes(df: pd.DataFrame):
    ec3_codes = get_ec3_codes(df)
    ec3_to_ec4 = df.groupby("ec4")["ec3"].first()
    order = ec3_to_ec4.map(ec3_codes).sort_values()
    return dict(zip(order.index, range(1, len(order) + 2)))


def get_predictor_classes(measurements: pd.DataFrame):
    out = (
        measurements.groupby(["organism", "ec3", "ec4", "is_natural"])
        .size()
        .rename("n_measurements")
        .sort_values(ascending=False)
        .reset_index()
    )
    out.index += 1
    return out


def get_cmdstanpy_input(
    measurements: pd.DataFrame,
    priors: Dict,
    likelihood: bool,
) -> Dict:
    """Get an input to cmdstanpy.CmdStanModel.sample.

    :param measurements: a pandas DataFrame whose rows represent measurements

    :param model_config: a dictionary with keys "priors", "likelihood" and
    "x_cols".

    """
    ec3_codes = get_ec3_codes(measurements)
    ec4_codes = get_ec4_codes(measurements)
    predictor_classes = get_predictor_classes(measurements)
    n_ec4_free = measurements.loc[
        lambda df: df.groupby("ec3")["ec4"].transform("nunique") > 1, "ec4"
    ].nunique()
    n_non_singleton_ec3 = len(
        measurements.groupby("ec3")["ec4"].nunique().loc[lambda s: s > 1]
    )
    measurement_to_predictor_class = (
        predictor_classes.reset_index()
        .set_index(["organism", "ec3", "ec4", "is_natural"])
        .reindex(measurements[["organism", "ec3", "ec4", "is_natural"]])["index"]
        .values
    )
    ec4_to_ec3_human = measurements.groupby("ec4")["ec3"].first()
    ec4_to_ec3_stan = [ec3_codes[ec4_to_ec3_human[s]] for s in ec4_codes.keys()]
    return {
        **priors,
        **{
            "N": measurements.shape[0],
            "N_ec4": measurements["ec4"].nunique(),
            "N_ec3": measurements["ec3"].nunique(),
            "N_ec2": measurements["ec2"].nunique(),
            "N_ec4_free": n_ec4_free,
            "N_non_singleton_ec3": n_non_singleton_ec3,
            "N_predictor_class": len(predictor_classes),
            "N_substrate": measurements["substrate"].nunique(),
            "N_subs": measurements["substrate"].nunique(),
            "N_species": measurements["organism"].nunique(),
            "ec4": predictor_classes["ec4"].map(ec4_codes).values,
            "ec3": predictor_classes["ec3"].map(ec3_codes).values,
            "predictor_class": measurement_to_predictor_class,
            "ec4_to_ec3": ec4_to_ec3_stan,
            "substrate": one_encode(measurements["substrate"]).values,
            "is_natural": predictor_classes["is_natural"].astype(int).values,
            "y": measurements["log_km"].values,
            "N_test": len(measurements),
            "y_test": measurements["log_km"].values,
            "likelihood": int(likelihood),
        },
    }


def get_infd_kwargs(measurements: pd.DataFrame, sample_kwargs: Dict) -> Dict:
    """Get a dictionary of keyword arguments to arviz.from_cmdstanpy.

    :param measurements: pandas dataframe whose rows represent
    measurements. Must be the same as was used for `get_stan_input`.

    :param x_cols: list of columns of `measurements` representing real-valued
    covariates. Must be the same as was used for `get_stan_input`.

    :param sample_kwargs: dictionary of keyword arguments that were passed to
    cmdstanpy.CmdStanModel.sample.

    """
    n_non_singleton_ec3 = len(
        measurements.groupby("ec3")["ec4"].nunique().loc[lambda s: s > 1]
    )
    predictor_classes = get_predictor_classes(measurements)
    return dict(
        log_likelihood="llik",
        observed_data={"y": measurements["log_km"].values},
        posterior_predictive="yrep",
        coords={
            "measurement": measurements.index.values,
            "ec4": list(get_ec4_codes(measurements).keys()),
            "ec3": list(get_ec3_codes(measurements).keys()),
            "ec3_non_singleton": list(get_ec3_codes(measurements).keys())[
                :n_non_singleton_ec3
            ],
            "substrate": pd.factorize(measurements["substrate"])[1].values,
            "organism": pd.factorize(measurements["organism"])[1].values,
            "predictor_class": predictor_classes.index,
        },
        dims={
            "yrep": ["measurement"],
            "yhat": ["predictor_class"],
            "llik": ["measurement"],
            "a_ec4": ["ec4"],
            "a_ec3": ["ec3"],
            "a_ec2": ["ec2"],
            "a_substrate": ["substrate"],
            "tau_ec3": ["ec3_non_singleton"],
        },
        save_warmup=sample_kwargs["save_warmup"],
    )
