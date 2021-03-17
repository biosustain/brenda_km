"""Prepare the data at RAW_DATA_CSV and save it to PREPARED_DATA_CSV."""

import pandas as pd
from src.data_preparation import prepare_data, RAW_DATA_CSV, PREPARED_DATA_CSV


def main():
    """Run the script."""
    print(f"Reading raw data from {RAW_DATA_CSV}")
    raw = pd.read_csv(RAW_DATA_CSV)
    out = prepare_data(raw)
    print(f"Writing prepared data to {PREPARED_DATA_CSV}")
    out.to_csv(PREPARED_DATA_CSV)


if __name__ == "__main__":
    main()
