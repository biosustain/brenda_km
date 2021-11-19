"""Fetch a list of all EC numbers from the EXPASY database.

User manual: https://ftp.expasy.org/databases/enzyme/enzuser.txt
Publication:
    Bairoch A.
    The ENZYME database in 2000.
    Nucleic Acids Res. 28:304-305(2000).
Other info: https://enzyme.expasy.org/

"""


import os

import requests

EXPASY_URL = "https://ftp.expasy.org/databases/enzyme/enzyme.dat"
OUTPUT_FILE = os.path.join("data", "raw", "expasy_ec_numbers.csv")


def main():
    ec_numbers = []
    response = requests.get(EXPASY_URL)
    response.raise_for_status()
    ec_lines = filter(lambda l: l.startswith("ID"), response.text.split("\n"))
    for l in ec_lines:
        ec_number = l.strip().split("   ")[1]
        ec_numbers.append(ec_number)
    with open(OUTPUT_FILE, "w") as f:
        f.write("\n".join(ec_numbers))
    print(f"Fetched {len(ec_numbers)} ec numbers and saved to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
