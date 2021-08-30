"""Function for generating fake data."""


import os

import numpy as np
import pandas as pd
from cmdstanpy import CmdStanModel

from .model_configurations_to_try import NATURAL as TRUE_MODEL_CONFIG
from .stan_io import get_ec3_codes

# True values for each variable in your program's `parameters` block. Make sure
# that the dimensions agree with `TRUE_MODEL_FILE`!
TRUE_PARAM_VALUES = {
    "baseline": -2,
    "b_natural": 0.3,
    "sigma": 2.4,
    "tau": 1.2,
}

HERE = os.path.dirname(os.path.abspath(__file__))
REAL_DATA_CSV = os.path.join(
    HERE, "..", "data", "prepared", "data_prepared.csv"
)


def generate_fake_measurements() -> pd.DataFrame:
    """Fake a table of measurements by simulating from the true model.

    You will need to customise this function to make sure it matches the data
    generating process you want to simulate from.

    """
    real_data = pd.read_csv(REAL_DATA_CSV)
    fake_data = real_data.copy()
    model = CmdStanModel(stan_file=TRUE_MODEL_CONFIG.stan_file)
    stan_input = TRUE_MODEL_CONFIG.stan_input_function(fake_data)
    true_param_values = TRUE_PARAM_VALUES.copy()
    true_param_values["tau_ec3"] = np.random.lognormal(
        stan_input["prior_tau_ec3"][0],
        stan_input["prior_tau_ec3"][1],
        stan_input["N_non_singleton_ec3"],
    ).tolist()
    true_param_values["a_ec3"] = (
        np.random.standard_t(4, stan_input["N_ec3"]) * TRUE_PARAM_VALUES["tau"]
    ).tolist()
    ec4_free_to_ec3 = (
        np.array(stan_input["ec4_to_ec3"])[: int(stan_input["N_ec4_free"])] - 1
    )
    true_param_values["a_ec4_free"] = (
        np.random.standard_t(4, stan_input["N_ec4_free"])
        * np.array(true_param_values["tau_ec3"])[ec4_free_to_ec3]
    )
    mcmc = model.sample(
        stan_input, inits=true_param_values, fixed_param=True, iter_sampling=1
    )
    log_km_sim = mcmc.stan_variable("yrep")[0]
    return fake_data.assign(km=np.exp(log_km_sim), log_km=log_km_sim)
