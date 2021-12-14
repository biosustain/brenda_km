"""Read the data in RAW_DATA_DIR and save prepared data to PREPARED_DATA_DIR."""

import json
import os
from glob import glob

import numpy as np
import pandas as pd
from cmdstanpy import CmdStanModel, write_stan_json

from src.data_preparation import prepare_data

RAW_DIR = os.path.join("data", "raw")
PREPARED_DIR = os.path.join("data", "prepared")
PREP_CONFIGS = [
    {
        "name": "km_tenfold",
        "raw_reports_file": os.path.join(RAW_DIR, "brenda_km_reports.csv"),
        "number_of_cv_folds": 10,
        "response_col": "km",
        "natural_only": True,
        "natural_ligands_file": os.path.join(
            RAW_DIR, "brenda_natural_substrates.csv"
        ),
    },
    {
        "name": "kcat_tenfold",
        "raw_reports_file": os.path.join(RAW_DIR, "brenda_kcat_reports.csv"),
        "number_of_cv_folds": 10,
        "response_col": "kcat",
        "natural_only": True,
        "natural_ligands_file": os.path.join(
            RAW_DIR, "brenda_natural_substrates.csv"
        ),
    },
]

# Used to generate fake data
TRUE_MODEL_FILE = os.path.join("src", "stan", "blk.stan")
HARDCODED_PARAMS = {
    "km": {
        "nu": 4,
        "mu": -2,
        "sigma": 0.8,
        "tau_substrate": 1.6,
        "tau_ec_sub": 0.6,
        "tau_org_sub": 1.1,
    },
    "kcat": {
        "nu": 4,
        "mu": -2,
        "sigma": 0.8,
        "tau_substrate": 1.6,
        "tau_ec_sub": 0.6,
        "tau_org_sub": 1.1,
    },
}
SAMPLE_KWARGS_SIM = {
    "chains": 1,
    "iter_warmup": 0,
    "iter_sampling": 1,
    "fixed_param": True,
}


def generate_prepared_data():
    """Save prepared data in the PREPARED_DATA_DIR."""

    for pc in PREP_CONFIGS:
        print(f"Reading raw data from {pc['raw_reports_file']}")
        raw_reports = pd.read_csv(pc["raw_reports_file"], index_col=0)
        print(f"Reading natural ligands data from {pc['natural_ligands_file']}")
        natural_ligands = pd.read_csv(pc["natural_ligands_file"], index_col=0)
        print("Preparing Stan input files...")
        print(f"\tPreparing Stan input {pc['name']}...")
        output_dir = os.path.join(PREPARED_DIR, pc["name"])
        splits_dir = os.path.join(output_dir, "splits")
        input_file_prior, input_file_posterior = (
            os.path.join(output_dir, f"stan_input_{s}.json")
            for s in ["prior", "posterior"]
        )
        if not os.path.exists(output_dir):
            os.mkdir(output_dir)
            print(splits_dir)
            os.mkdir(splits_dir)
        po = prepare_data(
            name=pc["name"],
            raw_reports=raw_reports,
            natural_ligands=natural_ligands,
            number_of_cv_folds=pc["number_of_cv_folds"],
            response_col=pc["response_col"],
            natural_only=pc["natural_only"],
        )
        po.df.to_csv(os.path.join(output_dir, "input_df.csv"))
        po.reports.to_csv(os.path.join(output_dir, "filtered_reports.csv"))
        write_stan_json(input_file_posterior, po.standict_posterior)
        write_stan_json(input_file_prior, po.standict_prior)
        for i, si in enumerate(po.standicts_cv):
            f = os.path.join(splits_dir, f"split_{str(i)}.json")
            write_stan_json(f, si)
        with open(os.path.join(output_dir, "coords.json"), "w") as f:
            json.dump(po.coords, f)
        with open(os.path.join(output_dir, "dims.json"), "w") as f:
            json.dump(po.dims, f)
        with open(os.path.join(output_dir, "split_ixs.json"), "w") as f:
            json.dump([(a.tolist(), b.tolist()) for a, b in po.splits], f)


def generate_fake_data():
    """Generate fake data.

    This function modifies the folders that generate_prepared_data creates, so
    make sure to run it afterwards!

    """
    for pc in PREP_CONFIGS:
        directory = os.path.join(PREPARED_DIR, pc["name"])
        print(f"Generating fake data for {directory}...")
        original_input_file = os.path.join(
            directory, "stan_input_posterior.json"
        )
        fake_input_file = os.path.join(directory, "stan_input_fake.json")
        fake_param_file = os.path.join(directory, "fake_data_params.json")
        with open(original_input_file, "r") as f:
            input_orig = json.load(f)
        hardcoded_params = HARDCODED_PARAMS[pc["response_col"]]
        rng_params = {
            f"a_{suff}": np.random.normal(
                0, hardcoded_params[f"tau_{suff}"], input_orig[f"N_{suff}"]
            ).tolist()
            for suff in ["substrate", "ec_sub", "org_sub"]
        }
        params = {**hardcoded_params, **rng_params}
        model = CmdStanModel(stan_file=TRUE_MODEL_FILE)
        sim = model.sample(data=input_orig, inits=params, **SAMPLE_KWARGS_SIM)
        generated_y = sim.stan_variable("yrep").reshape(-1)
        for param in rng_params.keys():
            print(f"min {param}:", min(params[param]))
            print(f"max {param}:", max(params[param]))
        input_fake = input_orig.copy()
        input_fake["y_train"] = generated_y
        input_fake["y_test"] = generated_y
        write_stan_json(fake_input_file, input_fake)
        write_stan_json(fake_param_file, params)


if __name__ == "__main__":
    generate_prepared_data()
    generate_fake_data()
