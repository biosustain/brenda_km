"""Function for generating fake data."""


import os
from cmdstanpy import CmdStanModel
import numpy as np
import pandas as pd

from .model_configurations_to_try import EC_MODEL_3_CONFIG as TRUE_MODEL_CONFIG


# True values for each variable in your program's `parameters` block. Make sure
# that the dimensions agree with `TRUE_MODEL_FILE`!
TRUE_PARAM_VALUES = {
    "mu": 0.1,
    "nu": 5,
    "sigma": 1.5,
    "tau": [0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1],
}
HIERARCHICAL_COLUMNS = [
    "ec4",
    "ec3",
    "ec2",
    "substrate",
    "superkingdom",
    "family",
    "genus",
    "species",
]

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
    for i, colname in enumerate(HIERARCHICAL_COLUMNS):
        true_param_values[f"a_{colname}"] = np.random.normal(
            0, true_param_values["tau"][i], fake_data[colname].nunique()
        )
    mcmc = model.sample(
        stan_input, inits=true_param_values, fixed_param=True, iter_sampling=1
    )
    log_km_sim = mcmc.stan_variable("yrep")[0]
    return fake_data.assign(km=np.exp(log_km_sim), log_km=log_km_sim)
