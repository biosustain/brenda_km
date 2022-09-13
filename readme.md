km-stats
==============================

Statistical models of kinetic parameter data from the BRENDA and SABIO-RK databases.


Fetching data
=============

Raw data can be found in the folder `data/raw/`.

This data was fetched using the script `fetch_data.py`. In order to run
this script, you will need to
[register](https://www.brenda-enzymes.org/register.php) with BRENDA and set
environment variables `BRENDA_EMAIL` and `BRENDA_PASSWORD` appropriately. You
will also need to install the python packages
[zeep](https://docs.python-zeep.org/en/master/) and
[tqdm](https://github.com/tqdm/tqdm).


Requirements
============

To install python dependencies run this terminal command in a suitable environment (python 3.7 or higher should work)

```sh
pip install -r requirements.txt
```

Note that this repository depends on [cmdstanpy](cmdstanpy.readthedocs.io/), which in turn has non-python dependencies. See [here](https://cmdstanpy.readthedocs.io/en/v0.9.77/installation.html#installing-cmdstan) for details about how to install these.

Reproducing our results
=======================

Our results can be reproduced by running the command `make results` from the project's root directory.

Individual components of the analysis can be reproduced by running the relevant
python scripts:

```sh
python fetch_data.py  # this takes a long time
python prepare_data.py
python generate_results.py
python analyse.py
```

Investigating the results
=========================

To investigate the results of a the `blk` model run, ensure that the file
`results/runs/blk/posterior/idata.nc` exists and then start our webapp with the
following command:

```sh
streamlit run app.py
```
