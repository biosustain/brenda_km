"""Prepare the data at RAW_DATA_CSV and save it to PREPARED_DATA_CSV."""

import json
import os

import pandas as pd
from cmdstanpy.utils import write_stan_json

from src.data_preparation import (
    PrepareDataInput,
    prepare_data_blk,
    prepare_data_lit,
    preprocess,
)

HERE = os.path.dirname(os.path.abspath(__file__))
RAW_DATA_DIR = os.path.join(HERE, "data", "raw")
PREPARED_DATA_DIR = os.path.join(HERE, "data", "prepared")
KM_MEASUREMENTS_CSV = os.path.join(RAW_DATA_DIR, "brenda_km_measurements.csv")
NATURAL_SUBSTRATES_CSV = os.path.join(
    RAW_DATA_DIR, "brenda_natural_substrates.csv"
)
PREPROCESSED_CSV = os.path.join(PREPARED_DATA_DIR, "km_preprocessed.csv")

NATURAL_ONLY_CSV = os.path.join(
    PREPARED_DATA_DIR, "data_prepared_natural_substrates_only.csv"
)
STAN_INPUT_DIR = os.path.join(HERE, "data", "stan_input")
COORDS_DIR = os.path.join(HERE, "data", "coords")
DIMS_DIR = os.path.join(HERE, "data", "dims")
PRIORS_CSV = os.path.join(HERE, "data", "priors", "priors.csv")


def main():
    """Run the script."""

    print(f"Reading raw data from {KM_MEASUREMENTS_CSV}")
    km = pd.read_csv(KM_MEASUREMENTS_CSV, index_col=0)
    nat = pd.read_csv(NATURAL_SUBSTRATES_CSV, index_col=0)

    print("Preprocessing...")
    pp = preprocess(km, nat)

    print(f"Writing pre-processed data to {PREPROCESSED_CSV}")
    pp.to_csv(PREPROCESSED_CSV, index=False)

    print("Preparing Stan input files...")
    priors = pd.read_csv(PRIORS_CSV)
    prep_inputs = [
        PrepareDataInput(
            prepare_data_lit, pp, priors, True, True, "lit_lik_nat"
        ),
        PrepareDataInput(
            prepare_data_lit, pp, priors, False, True, "lit_prior_nat"
        ),
        PrepareDataInput(
            prepare_data_blk, pp, priors, True, True, "blk_lik_nat"
        ),
    ]
    for pi in prep_inputs:
        name = pi.name
        print(f"\tPreparing Stan input {name}...")
        po = pi.prepare_func(pi.pp, pi.priors, pi.likelihood, pi.natural_only)
        po.df.to_csv(os.path.join(PREPARED_DATA_DIR, name + ".csv"))
        write_stan_json(
            os.path.join(STAN_INPUT_DIR, name + ".json"), po.stan_input
        )
        with open(os.path.join(COORDS_DIR, name + ".json"), "w") as f:
            json.dump(po.coords, f)
        with open(os.path.join(DIMS_DIR, name + ".json"), "w") as f:
            json.dump(po.dims, f)


if __name__ == "__main__":
    main()
