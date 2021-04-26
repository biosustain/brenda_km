"""Script for fetching data directly from BRENDA using their SOAP API.

NB Make sure that you have registered with BRENDA and that the environment
variables BRENDA_EMAIL and BRENDA_PASSWORD are set correctly.

"""


import zeep
import hashlib
import os
import time
import pandas as pd
from tqdm import tqdm

OUTPUT_FILEPATH = os.path.join("data", "raw", "raw_brenda_kms.csv")
WSDL = "https://www.brenda-enzymes.org/soap/brenda_zeep.wsdl"
CHUNKSIZE = 300


def main():
    email = os.environ["BRENDA_EMAIL"]
    password = os.environ["BRENDA_PASSWORD"]
    password_hex = hashlib.sha256(password.encode("utf-8")).hexdigest()
    client = zeep.Client(WSDL)
    ec_numbers = client.service.getEcNumbersFromEcNumber(email, password_hex)
    chunks = [
        ec_numbers[i: i+CHUNKSIZE]
        for i in range(0, len(ec_numbers), CHUNKSIZE)
    ]
    out = pd.DataFrame()
    for i, chunk in enumerate(chunks):
        print(f"Fetching ec numbers from {i*CHUNKSIZE} to {(i+1)*CHUNKSIZE-1}")
        time.sleep(2)
        client = zeep.Client(WSDL)
        for ec_number in tqdm(chunk):
            try:
                result = client.service.getKmValue(
                    email,
                    password_hex,
                    f"ecNumber*{ec_number}",
                    "organism*",
                    "kmValue*",
                    "kmValueMaximum*",
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
    out.to_csv(OUTPUT_FILEPATH)


if __name__ == "__main__":
    main()
