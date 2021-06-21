"""Define a list of ModelConfiguration objects called MODEL_CONFIGURATIONS."""

import os

import numpy as np

from .data_model import ModelConfiguration
from .stan_io import get_cmdstanpy_input, get_infd_kwargs
from .util import get_99_pct_params_ln, get_99_pct_params_n

# Locations of files
HERE = os.path.dirname(os.path.abspath(__file__))
STAN_FILE_EC_MODEL = os.path.join(HERE, "stan", "ec_model.stan")
STAN_FILE_SUBSTRATE_MODEL = os.path.join(HERE, "stan", "substrate_model.stan")
STAN_FILE_NATURAL_MODEL = os.path.join(HERE, "stan", "natural_model.stan")
STAN_FILE_EC_MODEL_3 = os.path.join(HERE, "stan", "ec_model_3.stan")

# Configuration for cmdstanpy.CmdStanModel.sample
SAMPLE_KWARGS = dict(
    show_progress=True,
    save_warmup=False,
    iter_warmup=400,
    iter_sampling=400,
    chains=2,
    refresh=1,
)

# Priors
PRIORS_EC = {
    "prior_nu": np.array([2, 0.1]),
    "prior_mu": get_99_pct_params_n(-3, 1),
    "prior_tau": get_99_pct_params_ln(0.4, 2.5),
    "prior_tau_ec3": get_99_pct_params_ln(0.02, 4),
    "prior_sigma": get_99_pct_params_ln(0.4, 3),
}
PRIORS_NATURAL = {
    **PRIORS_EC,
    **{"prior_b_natural": get_99_pct_params_n(-1, 0)}
}

# Configuration for EC only model
EC = ModelConfiguration(
    name="ec_model",
    stan_file=STAN_FILE_EC_MODEL,
    stan_input_function=lambda df: get_cmdstanpy_input(df, PRIORS_EC, True),
    infd_kwargs_function=lambda df: get_infd_kwargs(df, SAMPLE_KWARGS),
    sample_kwargs=SAMPLE_KWARGS,
)
# Configuration for EC plus substrate model
NATURAL = ModelConfiguration(
    name="natural_model",
    stan_file=STAN_FILE_NATURAL_MODEL,
    stan_input_function=lambda df: get_cmdstanpy_input(df, PRIORS_NATURAL, True),
    infd_kwargs_function=lambda df: get_infd_kwargs(df, SAMPLE_KWARGS),
    sample_kwargs=SAMPLE_KWARGS,
)
NATURAL_PRIOR = ModelConfiguration(
    name="natural_model",
    stan_file=STAN_FILE_NATURAL_MODEL,
    stan_input_function=lambda df: get_cmdstanpy_input(df, PRIORS_NATURAL, False),
    infd_kwargs_function=lambda df: get_infd_kwargs(df, SAMPLE_KWARGS),
    sample_kwargs=SAMPLE_KWARGS,
)

# A list of model configurations to test
MODEL_CONFIGURATIONS = [NATURAL]
