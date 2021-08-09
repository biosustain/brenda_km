"""Prepare the data at RAW_DATA_CSV and save it to PREPARED_DATA_CSV."""

import os

import pandas as pd
from cmdstanpy.utils import jsondump

from src.data_preparation import process_raw_data, prepare_data_cat_model

HERE = os.path.dirname(os.path.abspath(__file__))
RAW_DATA_DIR = os.path.join(HERE, "data", "raw")
PREPARED_DATA_DIR = os.path.join(HERE, "data", "prepared")

KM_MEASUREMENTS_CSV = os.path.join(RAW_DATA_DIR, "brenda_km_measurements.csv")
TEMPERATURE_OPTIMA_CSV = os.path.join(RAW_DATA_DIR, "brenda_temperature_optima.csv")
NATURAL_SUBSTRATES_CSV = os.path.join(RAW_DATA_DIR, "brenda_natural_substrates.csv")
PREPARED_DATA_CSV = os.path.join(PREPARED_DATA_DIR, "data_prepared.csv")
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
    km_measurements = pd.read_csv(KM_MEASUREMENTS_CSV)
    natural_substrates = pd.read_csv(NATURAL_SUBSTRATES_CSV)
    processed = process_raw_data(km_measurements, natural_substrates)
    print(f"Writing prepared data to {PREPARED_DATA_CSV}")
    processed.to_csv(PREPARED_DATA_CSV)
    print("Preparing Stan input files...")
    prior_df = pd.read_csv(PRIORS_CSV)
    for f, likelihood, name in [
        (prepare_data_cat_model, True, "cat_model_likelihood"),
        (prepare_data_cat_model, False, "cat_model_prior"),
    ]:
        stan_input, coords, dims = f(processed, prior_df, likelihood)
        jsondump(os.path.join(STAN_INPUT_DIR, name + ".json"), stan_input)
        jsondump(os.path.join(COORDS_DIR, name + ".json"), coords)
        jsondump(os.path.join(DIMS_DIR, name + ".json"), dims)


if __name__ == "__main__":
    main()
