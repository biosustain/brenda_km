"""Script for fetching data directly from BRENDA using their SOAP API.

NB Make sure that you have registered with BRENDA and that the environment
variables BRENDA_EMAIL and BRENDA_PASSWORD are set correctly.

"""

import hashlib
import os
import time
from typing import List

import pandas as pd
import zeep
from requests.exceptions import ConnectionError
from tqdm import tqdm
from zeep.exceptions import Error as ZeepError

OUTPUT_FILEPATHS = {
    "natural_substrates": os.path.join(
        "data", "raw", "brenda_natural_substrates.csv"
    ),
    "temperature_optima": os.path.join(
        "data", "raw", "brenda_temperature_optima.csv"
    ),
    "km_reports": os.path.join("data", "raw", "brenda_km_reports.csv"),
    "kcat_reports": os.path.join("data", "raw", "brenda_kcat_reports.csv"),
}
WSDL = "https://www.brenda-enzymes.org/soap/brenda_zeep.wsdl"
CHUNKSIZE = 100


def _fetch_ec_numbers(email: str, password_hex: str) -> List[str]:
    client = zeep.Client(WSDL)
    return client.service.getEcNumbersFromEcNumber(email, password_hex)


def _fetch_temperature_optima(
    email: str, password_hex: str, ec_numbers: List[str]
) -> pd.DataFrame:
    out = pd.DataFrame()
    chunksize = 40
    chunks = [
        ec_numbers[i : i + chunksize]
        for i in range(0, len(ec_numbers), chunksize)
    ]
    out = pd.DataFrame()
    for chunk in tqdm(chunks):
        client = zeep.Client(WSDL)
        for ec in chunk:
            try:
                result = client.service.getTemperatureOptimum(
                    email,
                    password_hex,
                    f"ecNumber*{ec}",
                    "temperatureOptimum*",
                    "temperatureOptimumMaximum*",
                    "commentary*",
                    "organism*",
                    "literature*",
                )
                result_df = pd.DataFrame.from_records(
                    map(lambda x: x.__dict__["__values__"], result)
                )
                out = pd.concat([out, result_df], ignore_index=True)
            except ZeepError as e:
                print(f"Error fetching temperature optima for enzyme {ec}:")
                print(e)
            except ConnectionError as e:
                print(f"Error fetching temperature optima for enzyme {ec}:")
                print(e)
    return out


def _fetch_natural_substrates(
    email: str, password_hex: str, ec_numbers: List[str]
) -> pd.DataFrame:
    client = zeep.Client(WSDL)
    out = pd.DataFrame()
    for ec in tqdm(ec_numbers):
        try:
            result = client.service.getNaturalSubstrate(
                email,
                password_hex,
                f"ecNumber*{ec}",
                "naturalSubstrate*",
                "naturalReactionPartners*",
                "organism*",
                "ligandStructureId*",
            )
            result_df = pd.DataFrame.from_records(
                map(lambda x: x.__dict__["__values__"], result)
            )
            out = pd.concat([out, result_df], ignore_index=True)
        except ZeepError as e:
            print(f"Error fetching temperature optima for enzyme {ec}:")
            print(e)
        except ConnectionError as e:
            print(f"Error fetching temperature optima for enzyme {ec}:")
            print(e)
    return out


def _fetch_reports(
    var: str,
    email: str,
    password_hex: str,
    ec_numbers: List[str],
    chunksize: int = CHUNKSIZE,
):
    chunks = [
        ec_numbers[i : i + chunksize]
        for i in range(0, len(ec_numbers), chunksize)
    ]
    out = pd.DataFrame()
    for i, chunk in enumerate(chunks):
        print(f"Fetching ec numbers from {chunk[0]} to {chunk[-1]}")
        print(
            f"i.e. {i*chunksize} to {(i+1)*chunksize-1} out of {len(ec_numbers)}."
        )
        time.sleep(2)
        client = zeep.Client(WSDL)
        fetch_func = (
            client.service.getKmValue
            if var == "kmValue"
            else client.service.getTurnoverNumber
        )
        for ec_number in tqdm(chunk):
            try:
                time.sleep(0.5)
                result = fetch_func(
                    email,
                    password_hex,
                    f"ecNumber*{ec_number}",
                    "organism*",
                    f"{var}*",
                    f"{var}Maximum*",
                    "substrate*",
                    "commentary*",
                    "ligandStructureId*",
                    "literature*",
                )
                result_df = pd.DataFrame.from_records(
                    map(lambda x: x.__dict__["__values__"], result)
                )
                out = pd.concat([out, result_df], ignore_index=True)
            except:
                print("\nError fetching ec number " + ec_number)
                time.sleep(2)
                client = zeep.Client(WSDL)
    return out


def main():
    email = os.environ["BRENDA_EMAIL"]
    password = os.environ["BRENDA_PASSWORD"]
    password_hex = hashlib.sha256(password.encode("utf-8")).hexdigest()
    print("Fetching ec numbers...")
    ec_numbers = sorted(_fetch_ec_numbers(email, password_hex))
    print(f"Found {len(ec_numbers)} ec numbers.")
    if not os.path.exists(OUTPUT_FILEPATHS["natural_substrates"]):
        print("Fetching natural substrates...")
        ns = _fetch_natural_substrates(email, password_hex, ec_numbers)
        ns.to_csv(OUTPUT_FILEPATHS["natural_substrates"])
    # if not os.path.exists(OUTPUT_FILEPATHS["temperature_optima"]):
    # print("Fetching temperature optima")
    # to = _fetch_temperature_optima(email, password_hex, ec_numbers)
    # to.to_csv(OUTPUT_FILEPATHS["temperature_optima"])
    if not os.path.exists(OUTPUT_FILEPATHS["kcat_reports"]):
        print("Fetching kcat reports...")
        kcat = _fetch_reports("turnoverNumber", email, password_hex, ec_numbers)
        kcat.to_csv(OUTPUT_FILEPATHS["kcat_reports"])
    if not os.path.exists(OUTPUT_FILEPATHS["km_reports"]):
        print("Fetching km reports...")
        km = _fetch_reports("kmValue", email, password_hex, ec_numbers)
        km.to_csv(OUTPUT_FILEPATHS["km_measurements"])


if __name__ == "__main__":
    main()
