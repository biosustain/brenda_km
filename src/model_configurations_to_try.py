"""Define a list of ModelConfiguration objects called MODEL_CONFIGURATIONS."""

import os
import numpy as np
from .util import get_99_pct_params_ln, get_99_pct_params_n
from .model_configuration import ModelConfiguration
from .pandas_to_cmdstanpy import get_stan_input
from .cmdstanpy_to_arviz import get_infd_kwargs


# Location of this file
HERE = os.path.dirname(os.path.abspath(__file__))

# Configure cmdstanpy.CmdStanModel.sample
SAMPLE_KWARGS = dict(
    show_progress=True,
    save_warmup=False,
    iter_warmup=2000,
    iter_sampling=2000,
)

PRIORS = {
    "prior_mu": get_99_pct_params_n(-1, 1),
    "prior_nu": np.array([2, 0.1]),
    "prior_b": [
        get_99_pct_params_n(-2, 2),
        get_99_pct_params_n(-2, 2),
    ],
    "prior_tau": [
        get_99_pct_params_ln(0.03, 2),
        get_99_pct_params_ln(0.03, 2),
        get_99_pct_params_ln(0.03, 1),
    ],
    "prior_sigma": get_99_pct_params_ln(0.4, 5.2),
}
X_COLS = ["temperature_m25", "dummy_col"]

# Configuration with likelihood set to False
TEMPERATURE_CONFIG_PRIOR = ModelConfiguration(
    name="temperature",
    stan_file=os.path.join("stan", "ec_model.stan"),
    stan_input_function=lambda df: get_stan_input(
        df,
        x_cols=X_COLS,
        priors=PRIORS,
        likelihood=False,
    ),
    infd_kwargs_function=lambda df: get_infd_kwargs(df, X_COLS, SAMPLE_KWARGS),
    sample_kwargs=SAMPLE_KWARGS,
)

# Configuration with likelihood set to True
TEMPERATURE_CONFIG_POSTERIOR = ModelConfiguration(
    name="temperature",
    stan_file=os.path.join("stan", "ec_model.stan"),
    stan_input_function=lambda df: get_stan_input(
        df,
        x_cols=X_COLS,
        priors=PRIORS,
        likelihood=True,
    ),
    infd_kwargs_function=lambda df: get_infd_kwargs(df, X_COLS, SAMPLE_KWARGS),
    sample_kwargs=SAMPLE_KWARGS,
)


# A list of model configurations to test
MODEL_CONFIGURATIONS = [TEMPERATURE_CONFIG_PRIOR, TEMPERATURE_CONFIG_POSTERIOR]
