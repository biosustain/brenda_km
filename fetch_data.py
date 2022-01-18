"""Script for fetching data directly from BRENDA using their SOAP API.

NB Make sure that you have registered with BRENDA and that the environment
variables BRENDA_EMAIL and BRENDA_PASSWORD are set correctly.

"""

import hashlib
import os
from functools import partial
from time import sleep
from typing import List

import pandas as pd
from tqdm.std import tqdm

from src.fetching import (
    fetch_brenda_natural_substrates,
    fetch_brenda_reports,
    fetch_expasy_ec_numbers,
    fetch_hmdb_metabolite_concentrations,
    fetch_sabio_data_for_ec_number,
)

OUTPUT_FILEPATHS = {
    "ec_numbers": os.path.join("data", "raw", "expasy_ec_numbers.csv"),
    "brenda_natural_substrates": os.path.join(
        "data", "raw", "brenda_natural_substrates.csv"
    ),
    "brenda_km_reports": os.path.join("data", "raw", "brenda_km_reports.csv"),
    "brenda_kcat_reports": os.path.join(
        "data", "raw", "brenda_kcat_reports.csv"
    ),
    "sabio_reports": os.path.join("data", "raw", "sabio_reports.csv"),
    "hmdb_metabolite_concentrations": os.path.join(
        "data", "raw", "hmdb_metabolite_concentrations.csv"
    ),
}
BRENDA_CHUNKSIZE = 100
SABIO_CHUNKSIZE = 500


def split_list_into_chunks(l: list, chunksize: int) -> List[list]:
    return [l[i : i + chunksize] for i in range(0, len(l), chunksize)]


def main():
    brenda_email = os.environ["BRENDA_EMAIL"]
    brenda_password = os.environ["BRENDA_PASSWORD"]
    brenda_hex = hashlib.sha256(brenda_password.encode("utf-8")).hexdigest()
    _fetch_brenda_reports, _fetch_brenda_natural_substrates = (
        partial(f, email=brenda_email, password_hex=brenda_hex)
        for f in (fetch_brenda_reports, fetch_brenda_natural_substrates)
    )

    if not os.path.exists(OUTPUT_FILEPATHS["ec_numbers"]):
        print("Fetching ec numbers...")
        ec_numbers = fetch_expasy_ec_numbers()
        fpath = OUTPUT_FILEPATHS["ec_numbers"]
        with open(fpath, "w") as f:
            f.write("\n".join(ec_numbers))
        print(f"Fetched {len(ec_numbers)} ec numbers and saved to {fpath}")
    else:
        with open(OUTPUT_FILEPATHS["ec_numbers"], "r") as f:
            ec_numbers = f.read().split("\n")
            print(f"Found {len(ec_numbers)} ec numbers.")

    if not os.path.exists(OUTPUT_FILEPATHS["brenda_natural_substrates"]):
        fpath = OUTPUT_FILEPATHS["brenda_natural_substrates"]
        print("Fetching natural substrates...")
        nat = _fetch_brenda_natural_substrates(ec_numbers=ec_numbers)
        nat.to_csv(fpath)
        print(f"Saved {len(nat)} natural substrates to {fpath}")

    if not os.path.exists(OUTPUT_FILEPATHS["brenda_kcat_reports"]):
        fpath = OUTPUT_FILEPATHS["brenda_kcat_reports"]
        print("Fetching BRENDA kcat reports...")
        kcat = pd.DataFrame([])
        for chunk in split_list_into_chunks(ec_numbers, BRENDA_CHUNKSIZE):
            chunk_df = _fetch_brenda_reports("turnoverNumber", ec_numbers=chunk)
            kcat = pd.concat([kcat, chunk_df], ignore_index=True)
            sleep(2)
        kcat.to_csv(fpath)
        print(f"Saved {len(kcat)} kcats to {fpath}")

    if not os.path.exists(OUTPUT_FILEPATHS["brenda_km_reports"]):
        fpath = OUTPUT_FILEPATHS["brenda_km_reports"]
        print("Fetching km reports...")
        km = pd.DataFrame([])
        for chunk in split_list_into_chunks(ec_numbers, BRENDA_CHUNKSIZE):
            chunk_df = _fetch_brenda_reports("kmValue", ec_numbers=chunk)
            km = pd.concat([km, chunk_df], ignore_index=True)
            sleep(2)
        km.to_csv(fpath)
        print(f"Saved {len(km)} kms to {fpath}")

    print("Fetching SABIO reports...")
    fpath_sabio = OUTPUT_FILEPATHS["sabio_reports"]
    try:
        sabio = pd.read_csv(fpath_sabio, index_col=0)
        saved_ecs = list(sabio["ECNumber"].unique())
        print(f"Found {len(sabio)} existing SABIO reports...")
    except FileNotFoundError:
        sabio = pd.DataFrame([])
        saved_ecs = []
        print("Found no existing SABIO reports...")
    ec_numbers_to_fetch = [ec for ec in ec_numbers if ec not in saved_ecs]
    pbar = tqdm(ec_numbers_to_fetch)
    for ec_number in pbar:
        pbar.set_description(f"Fetching data for EC {ec_number}")
        ec_df = fetch_sabio_data_for_ec_number(ec_number)
        sabio = pd.concat([sabio, ec_df], ignore_index=True)
        sabio.to_csv(fpath_sabio)
        sleep(0.2)
    n_sabio = sabio["parameter.startValue"].notnull().sum()
    print(f"Saved {n_sabio} sabio reports to {fpath_sabio}")

    if not os.path.exists(OUTPUT_FILEPATHS["hmdb_metabolite_concentrations"]):
        fpath = OUTPUT_FILEPATHS["hmdb_metabolite_concentrations"]
        print("Fetching natural human metabolite concentrations...")
        conc_df = fetch_hmdb_metabolite_concentrations()
        conc_df.to_csv(fpath)
        print(
            f"Saved {len(conc_df)} natural human metabolite concentration "
            f"records to {fpath}"
        )


if __name__ == "__main__":
    main()
