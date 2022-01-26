import time
import zipfile
from io import BytesIO, StringIO
from typing import IO, List
from xml.etree import cElementTree as ET

import pandas as pd
import requests
from tqdm import tqdm
from zeep.client import Client as ZeepClient
from zeep.exceptions import Error as ZeepError

BRENDA_WSDL = "https://www.brenda-enzymes.org/soap/brenda_zeep.wsdl"
EXPASY_URL = "https://ftp.expasy.org/databases/enzyme/enzyme.dat"
HMDB_URL = "https://hmdb.ca/system/downloads/current/hmdb_metabolites.zip"
HMDB_XML_FILENAME = "hmdb_metabolites.xml"
HMDB_PREF = "{http://www.hmdb.ca}"
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
    "Temperature",
    "pH",
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
    client = ZeepClient(BRENDA_WSDL)
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
    client = ZeepClient(BRENDA_WSDL)
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
            client = ZeepClient(BRENDA_WSDL)
    return out


def fetch_sabio_data_for_ec_number(ec_number: str) -> pd.DataFrame:
    query = {
        "format": "tsv",
        "fields[]": SABIO_FIELDS,
        "q": f'EnzymeType:"wildtype" AND IsRecombinant:false AND ECNumber:{ec_number}',
    }
    s = requests.Session()
    with s.get(SABIO_URL, params=query, stream=True) as r:
        r.raise_for_status()  # raise if 404 error
        out = pd.read_csv(StringIO(r.text), sep="\t")
        if len(out) == 0:
            out = pd.DataFrame({"ECNumber": [ec_number]})
        return out


def fetch_hmdb_metabolite_concentrations():
    """Fetch natural metabolite concentration data from hmdb.

    *********************** WARNING *******************************

    This script stores a large (~6.5GB) xml document in memory.

    If you run into memory problems, consider writing the xml document to disk
    before parsing.

    For example, change the last line of the function `download_xml` to this:

        return zipfile.ZipFile(bytes).extract(<SOME_LOCATION>)


    ***************************************************************

    """

    def download_xml(url: str, filename: str) -> IO[bytes]:
        print(f"Downloading metabolites from {url}...")
        bytes = BytesIO(requests.get(url, stream=True).content)
        print(f"Extracting zipped xml file {filename}...")
        return zipfile.ZipFile(bytes).open(filename)

    def parse_xml(xml: IO[bytes], pref: str) -> List:
        print("Parsing xml file...")
        out = []
        for _, elem in tqdm(ET.iterparse(xml, events=("end",))):
            if elem.tag == pref + "metabolite":
                metabolite_name = elem.find(pref + "name").text
                inchikey = elem.find(pref + "inchikey").text
                nc = elem.find(pref + "normal_concentrations")
                concentrations = nc.findall(pref + "concentration")
                for conc in concentrations:
                    cd = {"metabolite": metabolite_name, "inchikey": inchikey}
                    for k in conc:
                        if len(k) == 0:
                            cd[k.tag[len(pref) :]] = k.text
                    out.append(cd)
                elem.clear()
        return out

    xml_doc = download_xml(HMDB_URL, HMDB_XML_FILENAME)
    conc_dict = parse_xml(xml_doc, HMDB_PREF)
    return pd.DataFrame(conc_dict)
