"""Function for generating fake data."""

from typing import Dict

from cmdstanpy import CmdStanModel
import numpy as np
import pandas as pd

from model_configuration import ModelConfiguration


def generate_fake_measurements(
    param_values: Dict,
    model_config: ModelConfiguration,
    real_data: pd.DataFrame,
) -> pd.DataFrame:
    """Fake a table of measurements by simulating from the true model.

    You will need to customise this function to make sure it matches the data
    generating process you want to simulate from.

    :param param_values: a dictionary of true parameter values.

    :param model_config: configuration for the true model. Must have keys
    "stan_file" and "priors".

    :param real_data: pandas DataFrame of real data

    """
    fake_data = real_data.copy()
    model = CmdStanModel(stan_file=model_config.stan_file)
    stan_input = model_config.stan_input_function(fake_data)
    mcmc = model.sample(
        stan_input, inits=param_values, fixed_param=True, iter_sampling=1
    )
    return fake_data.assign(
        km=np.exp(mcmc.stan_variable("yrep")[0]),
        log_km=mcmc.stan_variable("yrep")[0],
    )
