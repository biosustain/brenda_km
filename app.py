"""Code for a streamlit webapp investigating our results."""

import base64
import os

import altair as alt
import arviz as az
import numpy as np
import pandas as pd
import streamlit as st
from scipy.stats import gaussian_kde

SUMMARY_CSV_FILE = os.path.join("results", "runs", "posterior_summary.csv")
IDATA_FILE = os.path.join("results", "runs", "posterior.nc")
VARS = ["mu", "a_substrate", "a_ec4_sub", "a_org_sub"]


@st.cache
def load_draws():
    """Get posterior draws."""
    idata = az.from_netcdf(IDATA_FILE)
    draws = az.extract_dataset(idata, var_names=VARS)
    draws.coords["biology"] = idata.posterior.coords["biology"]
    del idata
    return draws


@st.cache
def load_summary():
    """Get summary dataframe."""
    return pd.read_csv(SUMMARY_CSV_FILE)


def get_table_download_link(df: pd.DataFrame, text: str, filename: str):
    """Generate a link allowing a csv of a dataframe to be downloaded."""
    csv = df.to_csv(index=False)
    assert isinstance(csv, str)
    b64 = base64.b64encode(csv.encode()).decode()
    return (
        f'<a href="data:file/csv;base64,{b64}" download="{filename}">{text}</a>'
    )


# Start of app
st.title("Km distribution finder")

db = "BRENDA"
draws = load_draws(db)
summary_df = load_summary(db)

st.write(
    """
We fit some statistical models of Km measurements from the
[BRENDA](https://www.brenda-enzymes.org/). This webapp visualises the results.

Fill in the form, then click the button to see a KDE plot of a Km's marginal
posterior distribution.

"""
)

st.markdown(
    "You can also download a "
    + get_table_download_link(
        summary_df,
        "csv table of model results.",
        "posterior_summary.csv",
    ),
    unsafe_allow_html=True,
)
st.write(
    """
See [here](https://github.com/biosustain/km-stats) for the model's source code
and for instructions to reproduce the full posterior distribution.
"""
)


st.sidebar.write(
    "Choose which marginal posterior distribution you'd like to see!"
)

bios = draws.coords["biology"].to_series().unique().tolist()
orgs = draws.coords["biology_organism"].to_series().unique().tolist()

with st.sidebar:
    organism = st.selectbox("Organism", ["unknown"] + orgs)
    remaining_bios = [b for b in bios if b.split("|")[0] == organism]
    remaining_ec4s = [s.split("|")[1] for s in remaining_bios]
    ec4 = st.selectbox("EC4", ["unknown"] + remaining_ec4s)
    remaining_bios = [b for b in remaining_bios if b.split("|")[1] == ec4]
    ix_sub = 2 if db == "BRENDA" else 3
    remaining_subs = [s.split("|")[ix_sub] for s in remaining_bios]
    substrate = st.selectbox("Substrate", ["unknown"] + remaining_subs)
    ec4_sub, org_sub = (
        f"{thing}|{substrate}"
        if thing != "unknown" and substrate != "unknown"
        else "unknown"
        for thing in [ec4, organism]
    )
    biology = "|".join([organism, ec4, substrate])
    # get draws
    log_km = (
        draws["mu"]
        + draws["a_substrate"].sel({"substrate": substrate})
        + draws["a_ec4_sub"].sel({"ec4_sub": ec4_sub})
        + draws["a_org_sub"].sel({"org_sub": org_sub})
    )

low, median, high = log_km.quantile([0.01, 0.5, 0.99]).values
mean = float(log_km.mean())
sd = float(log_km.std())
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
rule = alt.Chart(median_df).mark_rule(color="black").encode(x="log km")
col1, col2 = st.columns([3, 2])
col1.altair_chart(kde_chart + kde_chart_bulk + rule)
col2.write(
    "Marginal posterior summary:"
    f"\n\n\tMean: {mean}"
    f"\n\n\tStandard deviation: {round(sd, 2)}"
    f"\n\n\t1% quantile: {round(low, 2)}"
    f"\n\n\tMedian: {median}"
    f"\n\n\t99% quantile: {round(high, 2)}"
)
