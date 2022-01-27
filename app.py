import base64
import json
import os
from typing import Any

import altair as alt
import arviz as az
import numpy as np
import pandas as pd
import streamlit as st
from arviz.data.inference_data import InferenceData
from genericpath import exists
from scipy.stats.kde import gaussian_kde
from xarray import DataArray
from xarray.core.dataset import Dataset

SUMMARY_CSV_FILE = os.path.join("results", "app_summary.csv")
RUN_DIRS = {
    "BRENDA": os.path.join("results", "runs", "brenda-km-blk"),
    "SABIO-RK": os.path.join("results", "runs", "sabio-km-enz"),
}
DATA_DIRS = {
    "BRENDA": os.path.join("data", "prepared", "brenda_km"),
    "SABIO-RK": os.path.join("data", "prepared", "sabio_km"),
}
BIOLOGY_COLS = {
    "BRENDA": ["organism", "substrate", "ec4"],
    "SABIO-RK": ["organism", "substrate", "ec4", "uniprot_id"],
}


def get_lit_link(e: Any, l: Any) -> str:
    lit = str(l).replace("[", "").replace("]", "")
    url = f"https://www.brenda-enzymes.org/literature.php?e={str(e)}&r={lit}"
    return f'<a href = "{url}">{lit}</a>'


def get_obs(reports: pd.DataFrame, biology: str) -> pd.DataFrame:
    obs = reports.query(f"biology == '{biology}'")
    assert isinstance(obs, pd.DataFrame)
    obs = obs.rename(columns={"log_km": "log km"})
    assert isinstance(obs, pd.DataFrame)
    obs["Posterior density"] = 0
    obs["reference"] = [
        get_lit_link(row["ec4"], row["literature"])
        for _, row in obs.reset_index().iterrows()
    ]
    obs["log km"] = obs["y"]
    obs["km"] = np.exp(obs["y"])
    return obs


def get_table_download_link(df: pd.DataFrame, text: str, filename: str):
    """Generates a link allowing a csv of a dataframe to be downloaded."""
    csv = df.to_csv(index=False)
    assert isinstance(csv, str)
    b64 = base64.b64encode(csv.encode()).decode()
    return (
        f'<a href="data:file/csv;base64,{b64}" download="{filename}">{text}</a>'
    )


def get_log_km_brenda(
    posterior: Dataset, ec4: str, organism: str, substrate: str
) -> DataArray:
    if substrate not in posterior.coords["substrate"]:
        substrate = "unknown substrate"
    ec_sub, org_sub = (
        f"{s}|{substrate}"
        if f"{s}|{substrate}" in posterior.coords[coord_name]
        else "unknown " + coord_name
        for s, coord_name in [(ec4, "ec4_sub"), (organism, "org_sub")]
    )
    mu = posterior["mu"]
    a_substrate = posterior["a_substrate"].sel({"substrate": substrate})
    a_ec_sub = posterior["a_ec4_sub"].sel({"ec4_sub": ec_sub})
    a_org_sub = posterior["a_org_sub"].sel({"org_sub": org_sub})
    return mu + a_substrate + a_ec_sub + a_org_sub


def get_log_km_sabio(
    posterior: Dataset, ec4: str, organism: str, substrate: str, uniprot_id: str
):
    enz_sub = f"{uniprot_id}|{substrate}"
    if enz_sub not in posterior.coords["enz_sub"]:
        enz_sub = "unknown enz_sub"
    a_enz_sub = posterior["a_enz_sub"].sel({"enz_sub": enz_sub})
    return get_log_km_brenda(posterior, ec4, organism, substrate) + a_enz_sub


def check_is_df(maybe_df) -> pd.DataFrame:
    assert isinstance(maybe_df, pd.DataFrame)
    return maybe_df


# Start of app
st.title("What do online databases say about my Kms?")

st.write(
    """
This webapp shows marginal posterior distributions for Km parameters from models we trained on data from the [BRENDA](https://www.brenda-enzymes.org/) and [SABIO-RK](http://sabio.h-its.org/).
"""
)

st.write(
    "The graph shows the posterior distribution (blue) and experimental measurements (red)."
)

st.sidebar.write(
    "Choose which marginal posterior distribution you'd like to see!"
)


# Get required data
db = st.sidebar.selectbox("Dataset", ["SABIO-RK", "BRENDA"])
posterior = az.from_netcdf(os.path.join(RUN_DIRS[db], "posterior.nc")).get(
    "posterior"
)
assert isinstance(posterior, Dataset)
lits = check_is_df(pd.read_csv(os.path.join(DATA_DIRS[db], "lits.csv")))
reports = check_is_df(pd.read_csv(os.path.join(DATA_DIRS[db], "reports.csv")))
summary_df = check_is_df(
    pd.read_csv(os.path.join(RUN_DIRS[db], "posterior_summary.csv"))
)

# map biologies to meaningful categories
biology_maps = {
    col: lits.groupby("biology")[col].first() for col in BIOLOGY_COLS[db]
}
options = {
    col: [f"Unknown {col}"] + s.unique().tolist()
    for col, s in biology_maps.items()
}

organism = st.sidebar.selectbox("Organism", options["organism"])
ec4 = st.sidebar.selectbox("EC4", options["ec4"])
substrate = st.sidebar.selectbox("Substrate", options["substrate"])
if db == "SABIO-RK":
    uniprot_id = st.sidebar.selectbox("Uniprot id", options["uniprot_id"])
    log_km = get_log_km_sabio(posterior, ec4, organism, substrate, uniprot_id)
    biology = "|".join([organism, ec4, uniprot_id, substrate])
else:
    log_km = get_log_km_brenda(posterior, ec4, organism, substrate)
    biology = "|".join([organism, ec4, substrate])
log_km = log_km.stack(dim=["chain", "draw"])
st.sidebar.markdown(
    get_table_download_link(
        summary_df,
        "Download a csv table of model results.",
        "posterior_summary.csv",
    ),
    unsafe_allow_html=True,
)
st.sidebar.markdown(
    get_table_download_link(
        reports,
        "Download a csv table of Km reports.",
        "reports.csv",
    ),
    unsafe_allow_html=True,
)
st.sidebar.write(
    "See [here](https://github.com/biosustain/km-stats) for the model's "
    "source code and for instructions to reproduce the full posterior "
    "distribution."
)

low, median, high = log_km.quantile([0.01, 0.5, 0.99]).values
mean = float(log_km.mean())
sd = float(log_km.std())
obs = get_obs(reports, biology)

kde = gaussian_kde(log_km)
x = np.linspace(log_km.min() - 0.1, log_km.max() + 0.1, 100)
is_bulk = (x > low) & (x < high)
y = kde(x)
kde_df = pd.DataFrame({"log km": x, "Posterior density": y})
kde_df_bulk = kde_df.copy().assign(
    **{"log km": kde_df["log km"].where(is_bulk)}
)
median_df = pd.DataFrame({"log km": median}, index=[0])

kde_chart = (
    alt.Chart(kde_df)
    .mark_area(opacity=0.2)
    .encode(x="log km", y="Posterior density")
)
kde_chart_bulk = (
    alt.Chart(kde_df_bulk).mark_area().encode(x="log km", y="Posterior density")
)
dots = (
    alt.Chart(obs)
    .mark_point(color="red")
    .encode(
        x="log km",
        y="Posterior density",
        tooltip=["literature", "km", "log km"],
    )
)
rule = alt.Chart(median_df).mark_rule(color="black").encode(x="log km")

col1, col2 = st.columns([3, 2])

col1.altair_chart(kde_chart + kde_chart_bulk + dots + rule)
col2.write(
    "Marginal posterior summary:"
    f"\n\n\tMean: {mean}"
    f"\n\n\tStandard deviation: {round(sd, 2)}"
    f"\n\n\t1% quantile: {round(low, 2)}"
    f"\n\n\tMedian: {median}"
    f"\n\n\t99% quantile: {round(high, 2)}"
)
st.write("Below is a table of all the measurements.")
st.write(
    check_is_df(obs.pipe(check_is_df).sort_values("log km"))
    .reset_index()[["reference", "km", "log km"]]
    .to_html(escape=False),
    unsafe_allow_html=True,
)
