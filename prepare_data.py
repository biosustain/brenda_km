"""Prepare the data at RAW_DATA_CSV and save it to PREPARED_DATA_CSV."""

import os

import pandas as pd

from src.data_preparation import prepare_data, prepare_data_natural_substrates_only

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


def main():
    """Run the script."""
    print(f"Reading raw data from {KM_MEASUREMENTS_CSV}")
    km_measurements = pd.read_csv(KM_MEASUREMENTS_CSV)
    natural_substrates = pd.read_csv(NATURAL_SUBSTRATES_CSV)
    out = prepare_data(km_measurements, natural_substrates)
    print(f"Writing prepared data to {PREPARED_DATA_CSV}")
    out.to_csv(PREPARED_DATA_CSV)
    nso = prepare_data_natural_substrates_only(km_measurements, natural_substrates)
    print(f"Writing natural substrates only data to {NATURAL_ONLY_CSV}")
    nso.to_csv(NATURAL_ONLY_CSV)


if __name__ == "__main__":
    main()
