"""Run all the configs in the model_configurations folder."""

import json
import os
from typing import Tuple

import arviz as az
import pandas as pd
import toml
import xarray
from arviz.data.inference_data import InferenceData
from xarray.core.dataset import Dataset

from src.analysis import generate_summary_df
from src.model_configuration import ModelConfiguration
from src.sampling import sample

MODEL_CONFIGURATION_DIR = "model_configurations"
RESULTS_DIR = os.path.join("results", "runs")
MODES = ["posterior", "fake", "prior"]


def load_jsons(mc) -> Tuple[dict, dict, dict]:
    with open(os.path.join(mc.data_dir, "coords.json"), "r") as f:
        coords = json.load(f)
    with open(os.path.join(mc.data_dir, "dims.json"), "r") as f:
        dims = json.load(f)
    with open(os.path.join(mc.data_dir, "biology_maps.json"), "r") as f:
        biology_maps = json.load(f)
    return coords, dims, biology_maps


def run_in_mode(mc: ModelConfiguration, mode: str) -> None:
    coords, dims, biology_maps = load_jsons(mc)
    run_dir = os.path.join(RESULTS_DIR, mc.name)
    idata_file = os.path.join(run_dir, f"{mode}.nc")
    input_json = os.path.join(mc.data_dir, f"stan_input_{mode}.json")
    print(f"\n***Fitting model {mc.name} in {mode} mode...***\n")
    idata = sample(
        stan_file=mc.stan_file,
        input_json=input_json,
        coords=coords,
        dims=dims,
        sample_kwargs=mc.sample_kwargs,
        diagnose=True,
        biology_maps=biology_maps,
    )
    summary = az.summary(
        idata, filter_vars="regex", var_names="^(?!(a_.*|yrep|llik|log_.*)).*"
    )
    print(summary)
    print(f"\n***Writing inference data to {idata_file}***\n")
    idata.to_netcdf(idata_file)
    # Generate summary table
    lits = pd.read_csv(os.path.join(mc.data_dir, "lits.csv"))
    assert isinstance(lits, pd.DataFrame)
    posterior = idata.get("posterior")
    assert isinstance(posterior, Dataset)
    if "log_km" in posterior.data_vars:
        summary_file = os.path.join(run_dir, f"{mode}_summary.csv")
        summary = generate_summary_df(posterior)
        print(f"\n***Writing summary table to {summary_file}***\n")
        summary.to_csv(summary_file)


def run_oos_cv(mc: ModelConfiguration) -> None:
    oos_cv = "out-of-sample cross validation"
    run_dir = os.path.join(RESULTS_DIR, mc.name)
    # load posterior in a way that lets us modify it
    az.rcParams["data.load"] = "eager"
    posterior_nc_file = os.path.join(run_dir, "posterior.nc")
    id_posterior = az.from_netcdf(posterior_nc_file)
    llik = id_posterior.get("log_likelihood")
    assert isinstance(llik, Dataset)
    assert isinstance(id_posterior, InferenceData)
    coords, dims, biology_maps = load_jsons(mc)
    if "llik_oos" in llik.data_vars:
        print(f"Found existing {oos_cv} results for model {mc.name}")
        return
    print(f"Running {oos_cv} for model {mc.name}")
    sample_kwargs = mc.sample_kwargs
    if mc.sample_kwargs_cross_validation is not None:
        sample_kwargs.update(mc.sample_kwargs_cross_validation)
    ooss = []
    cv_input_dir = os.path.join(mc.data_dir, "stan_inputs_cv")
    for f in sorted(os.listdir(cv_input_dir)):
        input_json_file = os.path.join(cv_input_dir, f)
        oos = sample(
            stan_file=mc.stan_file,
            input_json=input_json_file,
            coords=coords,
            dims=dims,
            sample_kwargs=sample_kwargs,
            diagnose=False,
            biology_maps=biology_maps,
        ).get("log_likelihood")
        ooss.append(oos)
    ooss_x = xarray.concat(ooss, dim="ix_test")
    print(f"\n***Updating {posterior_nc_file} with {oos_cv} results***\n")
    llik.update({"llik_oos": ooss_x["llik"].rename("llik_oos")})
    id_posterior.__delattr__("log_likelihood")
    id_posterior.add_groups({"log_likelihood": llik})
    id_posterior.to_netcdf(posterior_nc_file)


def main():
    config_files = [
        os.path.join(MODEL_CONFIGURATION_DIR, f)
        for f in os.listdir(MODEL_CONFIGURATION_DIR)
        if f.endswith(".toml")
    ]
    for config_file in sorted(config_files):
        mc = ModelConfiguration(**toml.load(config_file))
        run_dir = os.path.join(RESULTS_DIR, mc.name)
        if not os.path.exists(run_dir):
            os.mkdir(run_dir)
        for mode in MODES:
            nc_file = os.path.join(RESULTS_DIR, mc.name, f"{mode}.nc")
            if not os.path.exists(nc_file) and not mc.do_not_run:
                run_in_mode(mc, mode)
        if mc.run_cross_validation:
            run_oos_cv(mc)


if __name__ == "__main__":
    main()
