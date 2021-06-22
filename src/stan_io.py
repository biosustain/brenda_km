"""Functions for creating inputs for stan and doing things with stan outputs."""

from typing import Dict

import pandas as pd

from .util import one_encode

def get_organism_codes(df: pd.DataFrame):
    return dict(zip(
        df["organism"].unique(), range(1, df["organism"].nunique() + 2)
    ))


def get_ec3_codes(df: pd.DataFrame):
    order = df.groupby("ec3")["ec4"].nunique().sort_values(ascending=False)
    return dict(zip(order.index, range(1, len(order) + 2)))


def get_ec4_codes(df: pd.DataFrame):
    ec3_codes = get_ec3_codes(df)
    ec3_to_ec4 = df.groupby("ec4")["ec3"].first()
    order = ec3_to_ec4.map(ec3_codes).sort_values()
    return dict(zip(order.index, range(1, len(order) + 2)))


def get_all_predictors(measurements: pd.DataFrame) -> pd.DataFrame:
    """Get a series indicating what each predictor represents.

    Note that the predictors are ordered by number of occurrences
    """
    return (
        measurements.groupby(["organism", "ec3", "ec4", "is_natural"])
        .size()
        .rename("n_measurements")
        .sort_values(ascending=False)
        .reset_index()
        .drop("n_measurements", axis=1)
    )


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
    organism_codes = get_organism_codes(measurements)
    ec3_codes = get_ec3_codes(measurements)
    ec4_codes = get_ec4_codes(measurements)
    predictors = get_all_predictors(measurements)
    n_ec4_free = measurements.loc[
        lambda df: df.groupby("ec3")["ec4"].transform("nunique") > 1, "ec4"
    ].nunique()
    n_non_singleton_ec3 = len(
        measurements.groupby("ec3")["ec4"].nunique().loc[lambda s: s > 1]
    )
    predictors = get_all_predictors(measurements)
    predictor_to_code = dict(zip(map(tuple, predictors.values), range(1, len(predictors) + 1)))
    measurement_to_predictor_code = (
        measurements[["organism", "ec3", "ec4", "is_natural"]]
        .apply(lambda row: predictor_to_code[tuple(row.values)], axis=1)
    )
    ec4_to_ec3_human = measurements.groupby("ec4")["ec3"].first()
    ec4_to_ec3_stan = [ec3_codes[ec4_to_ec3_human[s]] for s in ec4_codes.keys()]
    return {
        **priors,
        **{
            "N": measurements.shape[0],
            "N_organism": measurements["organism"].nunique(),
            "N_ec4": measurements["ec4"].nunique(),
            "N_ec3": measurements["ec3"].nunique(),
            "N_ec4_free": n_ec4_free,
            "N_non_singleton_ec3": n_non_singleton_ec3,
            "N_predictor": len(predictors),
            "organism": predictors["organism"].map(organism_codes).values,
            "ec4": predictors["ec4"].map(ec4_codes).values,
            "ec3": predictors["ec3"].map(ec3_codes).values,
            "predictor": measurement_to_predictor_code.values,
            "ec4_to_ec3": ec4_to_ec3_stan,
            "substrate": one_encode(measurements["substrate"]).values,
            "is_natural": predictors["is_natural"].astype(int).values,
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
    predictors = get_all_predictors(measurements)
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
            "substrate": pd.factorize(measurements["substrate"])[1],
            "organism": pd.factorize(measurements["organism"])[1],
            "predictor_ix": predictors.index,
        },
        dims={
            "yrep": ["measurement"],
            "yhat": ["predictor_ix"],
            "epsilon": ["predictor_ix"],
            "llik": ["measurement"],
            "a_ec4": ["ec4"],
            "a_ec3": ["ec3"],
            "a_ec2": ["ec2"],
            "a_substrate": ["substrate"],
            "tau_ec3": ["ec3_non_singleton"],
            "tau_epsilon": ["organism"],
        },
        save_warmup=sample_kwargs["save_warmup"],
    )
