import base64
import json
import os

import altair as alt
import arviz as az
import numpy as np
import pandas as pd
import streamlit as st
from scipy.stats.kde import gaussian_kde

from src.data_preparation import BIOLOGY_FCTS

SUMMARY_CSV_FILE = os.path.join("results", "app_summary.csv")
IDATA_FILE = os.path.join("results", "idata", "idata_blk.nc")
PREPARED_DATA_FILE = os.path.join("data", "prepared", "lit_lik_nat.csv")
COORDS_FILE = os.path.join("data", "coords", "lit_lik_nat.json")


def get_lit_link(e: str, l: str) -> str:
    lit = l.replace("[", "").replace("]", "")
    url = f"https://www.brenda-enzymes.org/literature.php?e={e}&r={lit}"
    return f'<a href = "{url}">{lit}</a>'


def get_obs(
    msmts: pd.DataFrame, organism: str, ec4: str, substrate: str
) -> pd.DataFrame:
    biology = "|".join([ec4, organism, substrate])
    obs = msmts.loc[lambda df: df["biology"] == biology].rename(
        columns={"log_km": "log km"}
    )
    obs["Posterior density"] = 0
    obs["reference"] = [
        get_lit_link(row["ec4"], row["literature"])
        for _, row in obs.reset_index().iterrows()
    ]
    obs["log km"] = obs["y"]
    obs["km"] = np.exp(obs["y"])
    return obs


def check_if_natural(
    msmts: pd.DataFrame, organism: str, ec4: str, substrate: str
) -> bool:
    return (
        msmts.groupby(["organism", "ec4", "substrate"])["is_natural"]
        .first()
        .loc[(organism, ec4, substrate)]
    )


def get_table_download_link(df: pd.DataFrame, text: str, filename: str):
    """Generates a link allowing a csv of a dataframe to be downloaded."""
    csv = df.to_csv(index=False)
    b64 = base64.b64encode(csv.encode()).decode()
    return (
        f'<a href="data:file/csv;base64,{b64}" download="{filename}">{text}</a>'
    )


# non-choice-dependent data
msmts = pd.read_csv(PREPARED_DATA_FILE).reset_index()
idata = az.from_netcdf(IDATA_FILE).stack(chain_draw=["chain", "draw"])
with open(COORDS_FILE, "r") as f:
    coords = json.load(f)
log_km_posterior = idata.get("posterior")["log_km"]
biologies = pd.DataFrame.from_records(
    [l.split("|") for l in log_km_posterior.coords["biology"].values],
    columns=BIOLOGY_FCTS,
).assign(
    q_1pct=log_km_posterior.quantile(0.01, dim="chain_draw").values,
    median=log_km_posterior.quantile(0.5, dim="chain_draw").values,
    q_99pct=log_km_posterior.quantile(0.99, dim="chain_draw").values,
    mean=log_km_posterior.mean(dim="chain_draw").values,
    sd=log_km_posterior.std(dim="chain_draw").values,
)

# Start of app
st.title("What does BRENDA say?")

st.write(
    """
This webapp shows marginal posterior distributions for Km parameters from a model we trained on data from the [BRENDA database](https://www.brenda-enzymes.org/).
"""
)

st.write(
    "The graph shows the posterior distribution (blue) and experimental measurements (red)."
)

st.sidebar.write(
    "Choose which marginal posterior distribution you'd like to see!"
)


# Get required data
organism = st.sidebar.selectbox("Organism", biologies["organism"].unique())
ec4 = st.sidebar.selectbox(
    "EC4",
    biologies.groupby("organism")["ec4"].unique().loc[organism],
)
substrate = st.sidebar.selectbox(
    "Substrate",
    biologies.groupby(["organism", "ec4"])["substrate"]
    .unique()
    .loc[(organism, ec4)],
)

st.sidebar.markdown(
    get_table_download_link(
        biologies,
        "Download a csv table of model results.",
        "posterior_summary.csv",
    ),
    unsafe_allow_html=True,
)
st.sidebar.markdown(
    get_table_download_link(
        msmts,
        "Download a csv table of measurements.",
        "measurements.csv",
    ),
    unsafe_allow_html=True,
)
st.sidebar.write(
    "See [here](https://github.com/biosustain/brenda_km) for the model's "
    "source code and for instructions to reproduce the full posterior "
    "distribution."
)
biology = "|".join(map(str, [ec4, organism, substrate]))
# b_natural = idata.posterior["b_natural"]
yhat = idata.get("posterior")["log_km"].sel({"biology": biology})

low, median, high = yhat.quantile([0.01, 0.5, 0.99]).values
mean = float(yhat.mean())
sd = float(yhat.std())
obs = get_obs(msmts, organism, ec4, substrate)

kde = gaussian_kde(yhat)
x = np.linspace(yhat.min() - 0.1, yhat.max() + 0.1, 100)
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
    obs.sort_values("log km")
    .reset_index()[["reference", "is_natural", "km", "log km"]]
    .to_html(escape=False),
    unsafe_allow_html=True,
)
