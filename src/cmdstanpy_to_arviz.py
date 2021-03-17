"""Functions for turning cmdstanpy output into arviz InferenceData objects."""

from typing import List, Dict
import numpy as np
import pandas as pd


def get_infd_kwargs(
    measurements: pd.DataFrame, x_cols: List[str], sample_kwargs: Dict
) -> Dict:
    """Get a dictionary of keyword arguments to arviz.from_cmdstanpy.

    :param measurements: pandas dataframe whose rows represent
    measurements. Must be the same as was used for `get_stan_input`.

    :param x_cols: list of columns of `measurements` representing real-valued
    covariates. Must be the same as was used for `get_stan_input`.

    :param sample_kwargs: dictionary of keyword arguments that were passed to
    cmdstanpy.CmdStanModel.sample.

    """
    return dict(
        log_likelihood="llik",
        observed_data={"y": measurements["y"].values},
        posterior_predictive="yrep",
        coords={
            "covariate": x_cols,
            "measurement": measurements.index.values,
            "ec4": pd.factorize(measurements["ec4"])[1].values,
            "ec3": pd.factorize(measurements["ec3"])[1].values,
            "ec2": pd.factorize(measurements["ec2"])[1].values,
            "tau": np.array(["ec4", "ec3", "ec2"]),
        },
        dims={
            "b": ["covariate"],
            "yrep": ["measurement"],
            "llik": ["measurement"],
            "a_ec4": ["ec4"],
            "a_ec3": ["ec3"],
            "a_ec2": ["ec2"],
        },
        save_warmup=sample_kwargs["save_warmup"],
    )
