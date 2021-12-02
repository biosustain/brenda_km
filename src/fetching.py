import time
from io import StringIO
from typing import List

import pandas as pd
import requests
import zeep
from tqdm import tqdm
from zeep.exceptions import Error as ZeepError

EXPASY_URL = "https://ftp.expasy.org/databases/enzyme/enzyme.dat"
BRENDA_WSDL = "https://www.brenda-enzymes.org/soap/brenda_zeep.wsdl"
SABIO_SLEEP_INTERVAL = 20
SABIO_URL = "http://sabiork.h-its.org/sabioRestWebServices/kineticlawsExportTsv"
SABIO_FIELDS = [
    "EntryID",
    "Substrate",
    "EnzymeType",
    "PubMedID",
    "Organism",
    "UniprotID",
    "ECNumber",
    "Parameter",
]
SABIO_PARAMETER_TYPES = ["Km", "kcat"]


def fetch_expasy_ec_numbers() -> List[str]:
    """Get a list of all EC numbers from the expasy database."""
    out = []
    response = requests.get(EXPASY_URL)
    response.raise_for_status()
    ec_lines = filter(lambda l: l.startswith("ID"), response.text.split("\n"))
    for l in ec_lines:
        ec_number = l.strip().split("   ")[1]
        out.append(ec_number)
    return out


def fetch_brenda_natural_substrates(
    email: str, password_hex: str, ec_numbers: List[str]
) -> pd.DataFrame:
    """Get a dataframe of natural substrate information from BRENDA."""
    client = zeep.Client(BRENDA_WSDL)
    out = pd.DataFrame()
    pbar = tqdm(ec_numbers)
    for ec in pbar:
        pbar.set_description(f"Fetching data for EC {ec}")
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
            print(f"Error fetching natural substrates for EC {ec}:")
            print(e)
        except requests.ConnectionError as e:
            print(f"Error fetching natural substrates for EC {ec}:")
            print(e)
    return out


def fetch_brenda_reports(
    var: str, email: str, password_hex: str, ec_numbers: List[str]
):
    client = zeep.Client(BRENDA_WSDL)
    fetch_func = (
        client.service.getKmValue
        if var == "kmValue"
        else client.service.getTurnoverNumber
    )
    out = pd.DataFrame([])
    pbar = tqdm(ec_numbers)
    for ec_number in pbar:
        pbar.set_description(f"Fetching data for EC {ec_number}")
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
            client = zeep.Client(BRENDA_WSDL)
    return out


def fetch_sabio_data_for_ec_number(ec_number: str) -> pd.DataFrame:
    query = {"fields[]": SABIO_FIELDS, "q": f"ECNumber:{ec_number}"}
    request = requests.post(SABIO_URL, params=query)
    request.raise_for_status()  # raise if 404 error
    return (
        pd.read_csv(StringIO(request.text), sep="\t")
        .loc[lambda df: df["parameter.type"].isin(SABIO_PARAMETER_TYPES)]
        .copy()
    )


def fetch_sabio_reports(ec_numbers) -> pd.DataFrame:
    out = pd.DataFrame([])
    pbar = tqdm(ec_numbers)
    for i, ec_number in enumerate(pbar):
        pbar.set_description(f"Fetching data for EC {ec_number}")
        ec_df = fetch_sabio_data_for_ec_number(ec_number)
        out = pd.concat([out, ec_df], ignore_index=True)
        if i % SABIO_SLEEP_INTERVAL == 0:
            time.sleep(0.5)
    return out
