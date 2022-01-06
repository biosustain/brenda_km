"""Run all the configs in the model_configurations folder."""

import json
import os

import toml

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
        if not mc.do_not_run:
            run_dir = os.path.join(RESULTS_DIR, mc.name)
            if not os.path.exists(run_dir):
                os.mkdir(run_dir)
            modes = ["posterior", "fake", "prior"]
            for mode in modes:
                input_json = os.path.join(
                    mc.data_dir, f"stan_input_{mode}.json"
                )
                output_dir = os.path.join(run_dir, mode)
                if not os.path.exists(output_dir):
                    os.mkdir(output_dir)
                print(f"\n***Fitting model {mc.name} in {mode} mode...***\n")
                idata = sample(
                    stan_file=mc.stan_file,
                    input_json=input_json,
                    coords=coords,
                    dims=dims,
                    sample_kwargs=mc.sample_kwargs,
                )
                idata_file = os.path.join(output_dir, f"idata.nc")
                print(f"\n***Writing inference data to {idata_file}***\n")
                idata.to_netcdf(idata_file)
            if mc.run_cross_validation:
                cv_dir = os.path.join(run_dir, "splits")
                if not os.path.exists(cv_dir):
                    os.mkdir(cv_dir)
                if mc.sample_kwargs_cross_validation is None:
                    sample_kwargs = mc.sample_kwargs
                else:
                    sample_kwargs = {
                        **mc.sample_kwargs,
                        **mc.sample_kwargs_cross_validation,
                    }

                for f in sorted(os.listdir(cv_dir)):
                    output_dir = os.path.join(cv_dir, f.split(".")[0])
                    if not os.path.exists(output_dir):
                        os.mkdir(output_dir)
                    input_json = os.path.join(cv_dir, f)
                    idata = sample(
                        stan_file=mc.stan_file,
                        input_json=input_json,
                        coords=coords,
                        dims=dims,
                        sample_kwargs=sample_kwargs,
                    )
                    idata_file = os.path.join(output_dir, f"idata.nc")
                    print(f"\n***Writing inference data to {idata_file}***\n")
                    idata.to_netcdf(idata_file)


if __name__ == "__main__":
    main()
