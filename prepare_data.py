"""Prepare the data at RAW_DATA_CSV and save it to PREPARED_DATA_CSV."""

import json
import os

import pandas as pd
from cmdstanpy.utils import write_stan_json

from src.data_preparation import PrepareDataInput, prepare_data

HERE = os.path.dirname(os.path.abspath(__file__))
RAW_DATA_DIR = os.path.join(HERE, "data", "raw")
PREPARED_DATA_DIR = os.path.join(HERE, "data", "prepared")
KM_REPORTS_CSV = os.path.join(RAW_DATA_DIR, "brenda_km_reports.csv")
KCAT_REPORTS_CSV = os.path.join(RAW_DATA_DIR, "brenda_kcat_reports.csv")
NATURAL_SUBSTRATES_CSV = os.path.join(
    RAW_DATA_DIR, "brenda_natural_substrates.csv"
)
PREPROCESSED_CSV = os.path.join(PREPARED_DATA_DIR, "km_preprocessed.csv")


def main():
    """Run the script."""

    print(f"Reading raw data from {KM_REPORTS_CSV}")
    km_reports = pd.read_csv(KM_REPORTS_CSV, index_col=0)
    kcat_reports = pd.read_csv(KCAT_REPORTS_CSV, index_col=0)
    natural_ligands = pd.read_csv(NATURAL_SUBSTRATES_CSV, index_col=0)
    print("Preparing Stan input files...")
    prep_inputs = [
        PrepareDataInput(
            name="km_tenfold",
            raw_reports=km_reports,
            number_of_cv_folds=10,
            response_col="km",
            natural_only=True,
            natural_ligands=natural_ligands,
        ),
        PrepareDataInput(
            name="kcat_tenfold",
            raw_reports=kcat_reports,
            number_of_cv_folds=10,
            response_col="kcat",
            natural_only=True,
            natural_ligands=natural_ligands,
        ),
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
        po = prepare_data(pi)
        po.df.to_csv(os.path.join(output_dir, "input_df.csv"))
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


if __name__ == "__main__":
    main()
