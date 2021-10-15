"""Prepare the data at RAW_DATA_CSV and save it to PREPARED_DATA_CSV."""

import json
import os

import pandas as pd
from cmdstanpy.utils import write_stan_json

from src.data_preparation import PrepareDataInput, prepare_data, preprocess

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
    prep_inputs = [
        PrepareDataInput(prepare_data, pp, 10, "tenfold"),
    ]
    for pi in prep_inputs:
        print(f"\tPreparing Stan input {pi.name}...")
        output_dir = os.path.join(PREPARED_DATA_DIR, pi.name)
        splits_dir = os.path.join(output_dir, "splits")
        input_file_prior, input_file_posterior = (
            os.path.join(output_dir, f"stan_input_{s}.json")
            for s in ["prior", "posterior"]
        )
        if not os.path.exists(output_dir):
            os.mkdir(output_dir)
            print(splits_dir)
            os.mkdir(splits_dir)
        po = pi.prepare_func(pi.pp, pi.k)
        po.df.to_csv(os.path.join(output_dir, "input_df.csv"))
        write_stan_json(input_file_posterior, po.stan_input_posterior)
        write_stan_json(input_file_prior, po.stan_input_prior)
        for i, si in enumerate(po.stan_inputs_cv):
            f = os.path.join(splits_dir, f"split_{str(i)}.json")
            write_stan_json(f, si)
        with open(os.path.join(output_dir, "coords.json"), "w") as f:
            json.dump(po.coords, f)
        with open(os.path.join(output_dir, "dims.json"), "w") as f:
            json.dump(po.dims, f)
        with open(os.path.join(output_dir, "split_ixs.json"), "w") as f:
            json.dump([(a.tolist(), b.tolist()) for a, b in po.splits], f)


if __name__ == "__main__":
    main()
