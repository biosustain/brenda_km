"""Read the data in RAW_DIR and save prepared data to PREPARED_DIR."""

import json
import os
from typing import List

import numpy as np
import pandas as pd
from cmdstanpy import CmdStanModel, write_stan_json

from src.data_preparation import (
    PrepareDataOutput,
    check_is_df,
    prepare_data_brenda_km,
    prepare_data_sabio_km,
    prepare_sabio_concentrations,
)

RAW_DIR = os.path.join("data", "raw")
RAW_DATA_FILES = {
    "brenda_kcats": os.path.join(RAW_DIR, "brenda_kcat_reports.csv"),
    "brenda_kms": os.path.join(RAW_DIR, "brenda_km_reports.csv"),
    "sabio_reports": os.path.join(RAW_DIR, "sabio_reports.csv"),
    "brenda_nat_subs": os.path.join(RAW_DIR, "brenda_natural_substrates.csv"),
}

PREPARED_DIR = os.path.join("data", "prepared")
# Used to generate fake data
TRUE_MODEL_FILE = {
    "brenda_km": os.path.join("src", "stan", "blk.stan"),
    "sabio_km": os.path.join("src", "stan", "enz.stan"),
}
FAKE_DATA_SOURCE_DIR = os.path.join("data", "prepared", "sabio_km")
HARDCODED_PARAMS = {
    "nu": 4,
    "mu": -2,
    "sigma": 0.8,
    "tau_substrate": 1.6,
    "tau_org_sub": 1.1,
    "tau_ec4_sub": 0.6,
    "tau_enz_sub": 0.5,
}
SAMPLE_KWARGS_SIM = {
    "chains": 1,
    "iter_warmup": 0,
    "iter_sampling": 1,
    "fixed_param": True,
}


def generate_prepared_data():
    """Save prepared data in the PREPARED_DATA_DIR."""
    print("Reading raw data...")
    raw_data = {
        k: check_is_df(pd.read_csv(v, index_col=0))
        for k, v in RAW_DATA_FILES.items()
    }

    sabio_conc_output_file = os.path.join(PREPARED_DIR, "sabio_concs.csv")
    sabio_concs = prepare_sabio_concentrations(raw_data["sabio_reports"])
    sabio_concs.to_csv(sabio_conc_output_file)
    print(
        f"Saved {len(sabio_concs)} SABIO-RK metabolite concentrations to {sabio_conc_output_file}."
    )

    print("Preparing data...")
    brenda_km_data = prepare_data_brenda_km(
        name="brenda_km",
        raw_reports=raw_data["brenda_kms"],
        natural_ligands=raw_data["brenda_nat_subs"],
    )
    sabio_km_data = prepare_data_sabio_km("sabio_km", raw_data["sabio_reports"])
    prepare_data_outputs = [brenda_km_data, sabio_km_data]
    for po in prepare_data_outputs:
        output_dir = os.path.join(PREPARED_DIR, po.name)
        cv_dir = os.path.join(output_dir, "stan_inputs_cv")
        if not os.path.exists(output_dir):
            os.mkdir(output_dir)
            os.mkdir(cv_dir)
        input_file_prior, input_file_posterior = (
            os.path.join(output_dir, f"stan_input_{s}.json")
            for s in ["prior", "posterior"]
        )
        lit_file = os.path.join(output_dir, "lits.csv")
        po.lits.to_csv(lit_file)
        print(f"Saved {len(po.lits)} study/biology combinations to {lit_file}")
        report_file = os.path.join(output_dir, "reports.csv")
        po.reports.to_csv(report_file)
        print(f"Saved {len(po.reports)} reports to {report_file}")
        print("Saving handy jsons...")
        write_stan_json(input_file_posterior, po.standict_posterior)
        write_stan_json(input_file_prior, po.standict_prior)
        for i, si in enumerate(po.standicts_cv):
            f = os.path.join(cv_dir, f"split_{str(i)}.json")
            write_stan_json(f, si)
        with open(os.path.join(output_dir, "coords.json"), "w") as f:
            json.dump(po.coords, f)
        with open(os.path.join(output_dir, "dims.json"), "w") as f:
            json.dump(po.dims, f)
        with open(os.path.join(output_dir, "biology_maps.json"), "w") as f:
            json.dump(po.biology_maps, f)
    return prepare_data_outputs


def generate_fake_data(pos: List[PrepareDataOutput]):
    """Generate fake data.

    This function modifies the folders that generate_prepared_data creates, so
    make sure to run it afterwards!

    """

    for po in pos:
        directory = os.path.join(PREPARED_DIR, po.name)
        print(f"Generating fake data for {directory}...")
        original_input_file = os.path.join(
            directory, "stan_input_posterior.json"
        )
        fake_input_file = os.path.join(directory, "stan_input_fake.json")
        fake_param_file = os.path.join(directory, "fake_data_params.json")
        with open(original_input_file, "r") as f:
            input_orig = json.load(f)
        rng_params = {}
        for suff in ["substrate", "ec4_sub", "org_sub", "enz_sub"]:
            if f"N_{suff}" in input_orig.keys():
                rng_params[f"a_{suff}"] = np.array(
                    np.random.normal(
                        0,
                        HARDCODED_PARAMS[f"tau_{suff}"],
                        input_orig[f"N_{suff}"],
                    )
                ).tolist()
        params = {**HARDCODED_PARAMS, **rng_params}
        model = CmdStanModel(stan_file=TRUE_MODEL_FILE[po.name])
        sim = model.sample(data=input_orig, inits=params, **SAMPLE_KWARGS_SIM)
        generated_y = sim.stan_variable("yrep").reshape(-1)
        for param in rng_params.keys():
            print(f"min {param}:", min(params[param]))
            print(f"max {param}:", max(params[param]))
        input_fake = input_orig.copy()
        input_fake["y"] = generated_y
        write_stan_json(fake_input_file, input_fake)
        write_stan_json(fake_param_file, params)


if __name__ == "__main__":
    pos = generate_prepared_data()
    generate_fake_data(pos)
