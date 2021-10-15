brenda km
==============================

Statistical models of kinetic parameter data from BRENDA


Fetching data
=============

Raw km data from BRENDA can be found in the file `data/raw/brenda_km_measurements.csv`.

This data was fetched using the script `fetch_brenda_data.py`. In order to run
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


Fitting the model
=================

To fit the model run the following terminal command:

```sh
python fit_real_data.py
```

Investigating the results
=========================

To investigate the results of a pre-existing model run (it is an arviz
`InferenceData` object saved in netcdf format at `results/idata/app_idata.nc`),
start our webapp with the following command:

```sh
streamlit run app.py
```
