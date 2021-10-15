"""Functions for fitting models using cmdstanpy."""

import json
import os
from typing import Tuple

import arviz as az
from arviz.data.inference_data import InferenceData
from cmdstanpy import CmdStanModel
from cmdstanpy.stanfit import CmdStanMCMC

# Location of this file
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, "..")


def sample(
    stan_file: str,
    input_json: str,
    output_dir: str,
    coords: dict,
    dims: dict,
    sample_kwargs: dict,
    print_mode: bool = False,
) -> Tuple[CmdStanMCMC, InferenceData]:
    """Run cmdstanpy.CmdStanModel.sample, do diagnostics and save results.

    :param study_name: a string
    """
    loo_file = os.path.join(output_dir, f"loo.pkl")
    idata_file = os.path.join(output_dir, f"idata.nc")
    model = CmdStanModel(stan_file=stan_file)
    with open(input_json, "r") as f:
        stan_input = json.load(f)
    if print_mode:
        print(f"\n***Writing csv files to {output_dir}...***\n")
    mcmc = model.sample(data=stan_input, output_dir=output_dir, **sample_kwargs)
    if print_mode:
        print(mcmc.diagnose().replace("\n\n", "\n"))
    idata = az.from_cmdstanpy(
        posterior=mcmc,
        log_likelihood="llik",
        observed_data=stan_input,
        coords=coords,
        dims=dims,
    )
    if print_mode:
        print(az.summary(idata))
        print(f"\n***Writing inference data to {idata_file}***\n")
    idata.to_netcdf(idata_file)
    if stan_input["likelihood"] == 1:
        loo = az.loo(idata, pointwise=True)
        if print_mode:
            print(f"\n***Writing psis-loo results to {loo_file}***\n")
            print(loo)
        loo.to_pickle(loo_file)
    return mcmc, idata
