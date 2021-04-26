brenda km
==============================

Statistical models of kinetic parameter data from BRENDA


Fetching data
=============

Raw km data from BRENDA can be found in the file `data/raw/raw_brenda_kms.csv`.

This data was fetched using the script `fetch_brenda_data.py`. In order to run
this script, you will need to
[register](https://www.brenda-enzymes.org/register.php) with BRENDA and set
environment variables `BRENDA_EMAIL` and `BRENDA_PASSWORD` appropriately. You
will also need to install the python packages
[zeep](https://docs.python-zeep.org/en/master/) and
[tqdm](https://github.com/tqdm/tqdm).
