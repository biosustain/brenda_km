"""Download data from sabiork for every ec number.

This script depends on the file data/raw/expasy_ec_numbers.csv.

"""


import os
import time
from io import StringIO

import pandas as pd
import requests
from tqdm.std import tqdm

SLEEP_INTERVAL = 20
EC_NUMBER_FILE = os.path.join("data", "raw", "expasy_ec_numbers.csv")
QUERY_URL = "http://sabiork.h-its.org/sabioRestWebServices/kineticlawsExportTsv"
OUTPUT_FILE = os.path.join("data", "raw", "sabio_table.csv")
FIELDS = [
    "EntryID",
    "Substrate",
    "EnzymeType",
    "PubMedID",
    "Organism",
    "UniprotID",
    "ECNumber",
    "Parameter",
]
PARAMETER_TYPES = ["Km", "kcat"]


def fetch_sabio_data_for_ec_number(ec_number: str) -> pd.DataFrame:
    query = {"fields[]": FIELDS, "q": f"ECNumber:{ec_number}"}
    request = requests.post(QUERY_URL, params=query)
    request.raise_for_status()  # raise if 404 error
    return (
        pd.read_csv(StringIO(request.text), sep="\t")
        .loc[lambda df: df["parameter.type"].isin(PARAMETER_TYPES)]
        .copy()
    )


def main():
    out = pd.DataFrame([])
    fetched_ecs = []
    with open(EC_NUMBER_FILE, "r") as f:
        ec_numbers = sorted(f.read().split("\n"))
    if os.path.exists(OUTPUT_FILE):
        out = pd.read_csv(OUTPUT_FILE)
        fetched_ecs = out["ECNumber"].unique()
    ec_numbers = [ec for ec in ec_numbers if ec not in fetched_ecs]
    pbar = tqdm(ec_numbers)
    for i, ec_number in enumerate(pbar):
        pbar.set_description(f"Fetching data for ec number {ec_number}")
        ec_df = fetch_sabio_data_for_ec_number(ec_number)
        out = pd.concat([out, ec_df], ignore_index=True)
        if i % SLEEP_INTERVAL == 0:
            time.sleep(0.5)
            pbar.write(f"Writing {len(out)} results to {OUTPUT_FILE}")
            out.to_csv(OUTPUT_FILE)


if __name__ == "__main__":
    main()
