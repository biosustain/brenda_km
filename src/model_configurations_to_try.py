"""Define a list of ModelConfiguration objects called MODEL_CONFIGURATIONS."""

import os
import numpy as np
from .util import get_99_pct_params_ln, get_99_pct_params_n
from .model_configuration import ModelConfiguration
from .pandas_to_cmdstanpy import get_stan_input
from .cmdstanpy_to_arviz import get_infd_kwargs


# Location of this file
HERE = os.path.dirname(os.path.abspath(__file__))

STAN_FILE_EC_MODEL = os.path.join(HERE, "stan", "ec_model.stan")
STAN_FILE_EC_MODEL_3 = os.path.join(HERE, "stan", "ec_model_3.stan")
# Configure cmdstanpy.CmdStanModel.sample
SAMPLE_KWARGS = dict(
    show_progress=True,
    save_warmup=False,
    iter_warmup=500,
    iter_sampling=500,
    # adapt_delta=0.95,
    chains=2,
    refresh=1,
)

PRIORS_EC_MODEL = {
    "prior_nu": np.array([2, 0.1]),
    "prior_mu": get_99_pct_params_n(-2, 2),
    "prior_tau_ec3": get_99_pct_params_ln(0.4, 2.5),
    "prior_tau_ec4": get_99_pct_params_ln(0.02, 3),
    "prior_sigma": get_99_pct_params_ln(0.4, 5.2),
}
PRIORS_EC_MODEL_3 = {
    "prior_nu": np.array([2, 0.1]),
    "prior_mu": get_99_pct_params_n(-2, 2),
    "prior_tau": [
        get_99_pct_params_ln(0.03, 2),
        get_99_pct_params_ln(0.03, 2),
        get_99_pct_params_ln(0.03, 1),
        get_99_pct_params_ln(0.03, 1),
        get_99_pct_params_ln(0.03, 1),
        get_99_pct_params_ln(0.03, 1),
        get_99_pct_params_ln(0.03, 1),
        get_99_pct_params_ln(0.03, 1),
    ],
    "prior_sigma": get_99_pct_params_ln(0.4, 5.2),
}

# Configuration with likelihood set to False
BASIC = ModelConfiguration(
    name="ec_model",
    stan_file=STAN_FILE_EC_MODEL,
    stan_input_function=lambda df: get_stan_input(df, PRIORS_EC_MODEL, True),
    infd_kwargs_function=lambda df: get_infd_kwargs(df, SAMPLE_KWARGS),
    sample_kwargs=SAMPLE_KWARGS,
)

# Configuration with likelihood set to True
RICH = ModelConfiguration(
    name="ec_model_3",
    stan_file=STAN_FILE_EC_MODEL_3,
    stan_input_function=lambda df: get_stan_input(df, PRIORS_EC_MODEL_3, True),
    infd_kwargs_function=lambda df: get_infd_kwargs(df, SAMPLE_KWARGS),
    sample_kwargs=SAMPLE_KWARGS,
)


# A list of model configurations to test
MODEL_CONFIGURATIONS = [BASIC]
