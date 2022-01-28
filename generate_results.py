"""Run all the configs in the model_configurations folder."""

import json
import os

import arviz as az
import pandas as pd
import toml
import xarray

from src.analysis import generate_summary_df
from src.model_configuration import ModelConfiguration
from src.sampling import sample

MODEL_CONFIGURATION_DIR = "model_configurations"
RESULTS_DIR = os.path.join("results", "runs")


def main():
    config_files = [
        os.path.join(MODEL_CONFIGURATION_DIR, f)
        for f in os.listdir(MODEL_CONFIGURATION_DIR)
        if f.endswith(".toml")
    ]
    for config_file in sorted(config_files):
        mc = ModelConfiguration(**toml.load(config_file))
        with open(os.path.join(mc.data_dir, "coords.json"), "r") as f:
            coords = json.load(f)
        with open(os.path.join(mc.data_dir, "dims.json"), "r") as f:
            dims = json.load(f)
        with open(os.path.join(mc.data_dir, "biology_maps.json"), "r") as f:
            biology_maps = json.load(f)
        if not mc.do_not_run:
            run_dir = os.path.join(RESULTS_DIR, mc.name)
            if not os.path.exists(run_dir):
                os.mkdir(run_dir)
            modes = ["posterior"]
            # modes = ["posterior", "fake", "prior"]
            for mode in modes:
                input_json = os.path.join(
                    mc.data_dir, f"stan_input_{mode}.json"
                )
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
                idata_file = os.path.join(run_dir, f"{mode}.nc")
                print(f"\n***Writing inference data to {idata_file}***\n")
                idata.to_netcdf(idata_file)
                # Generate summary table
                lits = pd.read_csv(os.path.join(mc.data_dir, "lits.csv"))
                assert isinstance(lits, pd.DataFrame)
                summary_file = os.path.join(run_dir, f"{mode}_summary.csv")
                summary = generate_summary_df(idata)
                print(f"\n***Writing summary table to {summary_file}***\n")
                summary.to_csv(summary_file)

            if mc.run_cross_validation:
                if mc.sample_kwargs_cross_validation is None:
                    sample_kwargs = mc.sample_kwargs
                else:
                    sample_kwargs = {
                        **mc.sample_kwargs,
                        **mc.sample_kwargs_cross_validation,
                    }
                lliks = []
                cv_input_dir = os.path.join(mc.data_dir, "stan_inputs_cv")
                for f in sorted(os.listdir(cv_input_dir)):
                    input_json_file = os.path.join(cv_input_dir, f)
                    llik = sample(
                        stan_file=mc.stan_file,
                        input_json=input_json_file,
                        coords=coords,
                        dims=dims,
                        sample_kwargs=sample_kwargs,
                        diagnose=False,
                        biology_maps=biology_maps,
                    ).get("log_likelihood")
                    lliks.append(llik)
                full_llik = xarray.concat(lliks, dim="ix_test")
                cv_idata = az.InferenceData(log_likelihood=full_llik)
                idata_file = os.path.join(run_dir, "cv.nc")
                print(f"\n***Writing inference data to {idata_file}***\n")
                cv_idata.to_netcdf(idata_file)


if __name__ == "__main__":
    main()
