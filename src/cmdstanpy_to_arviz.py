"""Functions for turning cmdstanpy output into arviz InferenceData objects."""

from typing import List, Dict
import numpy as np
import pandas as pd

from .util import one_encode


def get_infd_kwargs(measurements: pd.DataFrame, sample_kwargs: Dict) -> Dict:
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
        observed_data={"y": measurements["log_km"].values},
        posterior_predictive="yrep",
        coords={
            "measurement": measurements.index.values,
            "ec4": pd.factorize(measurements["ec4"])[1].values,
            "ec3": pd.factorize(measurements["ec3"])[1].values,
            "ec2": pd.factorize(measurements["ec2"])[1].values,
            "substrate": pd.factorize(measurements["substrate"])[1].values,
            "superkingdom": pd.factorize(measurements["superkingdom"])[
                1
            ].values,
            "family": pd.factorize(measurements["family"])[1].values,
            "genus": pd.factorize(measurements["genus"])[1].values,
            "species": pd.factorize(measurements["species"])[1].values,
        },
        dims={
            "yrep": ["measurement"],
            "llik": ["measurement"],
            "a_ec4": ["ec4"],
            "a_ec3": ["ec3"],
            "a_ec2": ["ec2"],
            "tau_ec4": ["ec3"],
            "a_subs": ["substrate"],
            "a_superking": ["superkingdom"],
            "a_family": ["family"],
            "a_genus": ["genus"],
            "a_species": ["species"],
        },
        save_warmup=sample_kwargs["save_warmup"],
    )
