"""Functions for fitting models using cmdstanpy."""

import os
import arviz as az
from cmdstanpy import CmdStanModel
from cmdstanpy.utils import jsondump

from .loading import load_stan_input, load_coords, load_model_configuration
from .model_configuration import ModelConfiguration

# Location of this file
HERE = os.path.dirname(os.path.abspath(__file__))

# Where to save files
LOO_DIR = os.path.join(HERE, "..", "results", "loo")
SAMPLES_DIR = os.path.join(HERE, "..", "results", "samples")
IDATA_DIR = os.path.join(HERE, "..", "results", "infd")
JSON_DIR = os.path.join(HERE, "..", "results", "input_data_json")


def sample(mc: ModelConfiguration):
    """Run cmdstanpy.CmdStanModel.sample, do diagnostics and save results.

    :param study_name: a string
    """
    # infds = {}
    # for model_config in model_configurations:
    print(f"\n***Fitting model {mc.name}...***\n")
    loo_file = os.path.join(LOO_DIR, f"loo_{mc.name}.pkl")
    idata_file = os.path.join(IDATA_DIR, f"idata_{mc.name}.nc")
    json_file = os.path.join(JSON_DIR, f"input_data_{mc.name}.json")
    stan_file = os.path.join(HERE, "..", mc.stan_file)
    stan_input = load_stan_input(mc)
    coords = load_coords(os.path.join(HERE, "..", mc.data_file))
    print(f"\n***Writing input data to {json_file}***\n")
    jsondump(json_file, stan_input)
    model = CmdStanModel(model_name=mc.name, stan_file=stan_file)
    print(f"\n***Writing csv files to {SAMPLES_DIR}...***\n")
    mcmc = model.sample(
        data=stan_input,
        output_dir=SAMPLES_DIR,
        **mc.sample_kwargs,
    )
    print(mcmc.diagnose().replace("\n\n", "\n"))
    idata = az.from_cmdstan(
        posterior=mcmc.runset.csv_files,
        log_likelihood="llik",
        coords=coords,
        dims={
            "yrep": ["measurement"],
            "llik": ["measurement"],
            "a_ec4": ["ec4"],
            "a_ec3": ["ec3"],
            "a_ec2": ["ec2"],
            "a_cat": ["cat"],
            "a_substrate": ["substrate"],
            "tau_ec4": ["ec3"],
            "yhat": ["cat"],
        },
    )
    print(az.summary(idata))
    print(f"\n***Writing inference data to {idata_file}***\n")
    idata.to_netcdf(idata_file)
    print(f"\n***Writing psis-loo results to {loo_file}***\n")
    loo = az.loo(idata, pointwise=True)
    print(loo)
    loo.to_pickle(loo_file)
    return mcmc, idata
