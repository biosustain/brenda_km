"""Run all the configs in the model_configurations folder."""

import argparse
import json
import os
from typing import Tuple

import arviz as az
import pandas as pd
import toml
import xarray
from xarray.core.dataset import Dataset

from src.analysis import generate_summary_df
from src.model_configuration import ModelConfiguration
from src.sampling import sample

MODEL_CONFIGURATION_DIR = "model_configurations"
FINAL_MODEL_CONFIGURATIONS = [
    os.path.join(MODEL_CONFIGURATION_DIR, "brenda-blk.toml"),
    os.path.join(MODEL_CONFIGURATION_DIR, "sabio-enz.toml"),
]
RESULTS_DIR = os.path.join("results", "runs")
MODES = ["posterior", "fake", "prior", "cross_validation"]
APP_DIR = os.path.join(RESULTS_DIR, "brenda-blk")
APP_VARS = ["mu", "a_substrate", "a_ec4_sub", "a_org_sub"]
APP_N_SAMPLES = 500
APP_BIG_JSON = os.path.join(APP_DIR, "posterior.json")
APP_SMALL_JSON = os.path.join(APP_DIR, "app_draws.json")


def load_jsons(mc) -> Tuple[dict, dict]:
    """Load coords and dims from files."""
    with open(os.path.join(mc.data_dir, "coords.json"), "r") as f:
        coords = json.load(f)
    with open(os.path.join(mc.data_dir, "dims.json"), "r") as f:
        dims = json.load(f)
    return coords, dims


def run_in_mode(mc: ModelConfiguration, mode: str) -> None:
    """Run a model configuration in a mode other than cross-validation."""
    coords, dims = load_jsons(mc)
    run_dir = os.path.join(RESULTS_DIR, mc.name)
    idata_file = os.path.join(run_dir, f"{mode}.json")
    input_json = os.path.join(mc.data_dir, f"stan_input_{mode}.json")
    print(f"\n***Fitting model {mc.name} in {mode} mode...***\n")
    idata = sample(
        stan_file=mc.stan_file,
        input_json=input_json,
        coords=coords,
        dims=dims,
        sample_kwargs=mc.sample_kwargs,
        diagnose=True,
    )
    summary = az.summary(
        idata, filter_vars="regex", var_names="^(?!(a_.*|yrep|llik|log_.*)).*"
    )
    print(summary)
    print(f"\n***Writing inference data to {idata_file}***\n")
    idata.to_json(idata_file)
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


def main():
    """Run the script."""
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--final-only",
        action="store_true",
        help="Only run the final model configuration.",
    )
    final_only = parser.parse_args().final_only
    config_files = (
        [f for f in FINAL_MODEL_CONFIGURATIONS if os.path.exists(f)]
        if final_only
        else [
            os.path.join(MODEL_CONFIGURATION_DIR, f)
            for f in os.listdir(MODEL_CONFIGURATION_DIR)
            if f.endswith(".toml")
        ]
    )
    for config_file in sorted(config_files):
        mc = ModelConfiguration(**toml.load(config_file))
        run_dir = os.path.join(RESULTS_DIR, mc.name)
        if not os.path.exists(run_dir):
            os.mkdir(run_dir)
        for mode in MODES:
            if mode == "cross_validation":
                llik_file = os.path.join(run_dir, "llik_cv.json")
                if not os.path.exists(llik_file) and not mc.do_not_run:
                    coords, dims = load_jsons(mc)
                    lliks = []
                    cv_input_dir = os.path.join(mc.data_dir, "stan_inputs_cv")
                    for f in sorted(os.listdir(cv_input_dir)):
                        input_json_file = os.path.join(cv_input_dir, f)
                        llik = sample(
                            stan_file=mc.stan_file,
                            input_json=input_json_file,
                            coords={
                                k: v
                                for k, v in coords.items()
                                if k != "observation"
                            },
                            diagnose=False,
                            sample_kwargs={**mc.sample_kwargs, **{"chains": 1}},
                            dims=dims,
                        ).get("log_likelihood")
                        lliks.append(llik)
                        full_llik = az.convert_to_inference_data(
                            xarray.concat(lliks, dim="ix_test")
                        )
                    print(
                        "\n***Writing out-of-sample log likelihoods to "
                        f"{llik_file}***\n"
                    )
                    full_llik.to_json(llik_file)
            else:
                json_file = os.path.join(RESULTS_DIR, mc.name, f"{mode}.json")
                if not os.path.exists(json_file) and not mc.do_not_run:
                    run_in_mode(mc, mode)
    # Save a small version of the app posterior
    if os.path.exists(APP_BIG_JSON) and not os.path.exists(APP_SMALL_JSON):
        idata_big = az.from_json(APP_BIG_JSON)
        dataset_small = (
            az.extract_dataset(
                idata_big,
                group="posterior",
                var_names=APP_VARS,
            )
            .isel(sample=slice(None, APP_N_SAMPLES))
            .unstack()
            .transpose("chain", "draw", ...)
        )
        idata_small = az.convert_to_inference_data(
            dataset_small, coords=dataset_small.coords
        )
        print(
            f"Writing a small version of {APP_BIG_JSON} to {APP_SMALL_JSON}..."
        )
        idata_small.to_json(os.path.join(APP_DIR, "app_draws.json"))


if __name__ == "__main__":
    main()
