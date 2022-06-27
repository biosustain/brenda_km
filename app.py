"""Code for a streamlit webapp investigating our results."""

import base64
import os

import altair as alt
import arviz as az
import numpy as np
import pandas as pd
import streamlit as st
from scipy.stats.kde import gaussian_kde
from xarray import DataArray
from xarray.core.dataset import Dataset

SUMMARY_CSV_FILE = os.path.join("results", "final_summary.csv")
IDATA_FILE = os.path.join("results", "final_idata.nc")
RUN_DIRS = {
    "BRENDA": os.path.join("results", "runs", "brenda-blk"),
    "SABIO-RK": os.path.join("results", "runs", "sabio-enz"),
}
DATA_DIRS = {
    "BRENDA": os.path.join("data", "prepared", "brenda"),
    "SABIO-RK": os.path.join("data", "prepared", "sabio"),
}
BIOLOGY_COLS = {
    "BRENDA": ["organism", "substrate", "ec4"],
    "SABIO-RK": ["organism", "substrate", "ec4", "uniprot_id"],
}


def load_draws(db):
    """Get posterior draws."""
    return az.from_netcdf(
        os.path.join(RUN_DIRS[db], "posterior.nc")
    ).posterior.stack(dim=["chain", "draw"])


@st.cache
def load_summary(db):
    """Get summary dataframe."""
    return pd.read_csv(os.path.join(RUN_DIRS[db], "posterior_summary.csv"))


def get_table_download_link(df: pd.DataFrame, text: str, filename: str):
    """Generate a link allowing a csv of a dataframe to be downloaded."""
    csv = df.to_csv(index=False)
    assert isinstance(csv, str)
    b64 = base64.b64encode(csv.encode()).decode()
    return (
        f'<a href="data:file/csv;base64,{b64}" download="{filename}">{text}</a>'
    )


def get_log_km_brenda_blk(
    posterior: Dataset, ec4: str, organism: str, substrate: str
) -> DataArray:
    """Get a DataArray of log kms for the brenda-blk model."""
    # if substrate not in posterior.coords["substrate"]:
    # substrate = "unknown substrate"
    ec4_sub = f"{ec4}|{substrate}"
    if ec4_sub not in posterior.coords["ec4_sub"]:
        ec4_sub = "unknown"
    org_sub = f"{organism}|{substrate}"
    if org_sub not in posterior.coords["org_sub"]:
        org_sub = "unknown"
    mu = posterior["mu"]
    a_substrate = posterior["a_substrate"].sel({"substrate": substrate})
    a_ec_sub = posterior["a_ec4_sub"].sel({"ec4_sub": ec4_sub})
    a_org_sub = posterior["a_org_sub"].sel({"org_sub": org_sub})
    return mu + a_substrate + a_ec_sub + a_org_sub


def get_log_km_sabio_enz(
    posterior: Dataset, ec4: str, organism: str, substrate: str, uniprot_id: str
) -> DataArray:
    """Get a DataArray of log kms for the sabio-enz model."""
    enz_sub = f"{uniprot_id}|{substrate}"
    if enz_sub not in posterior.coords["enz_sub"]:
        enz_sub = "unknown"
    a_enz_sub = posterior["a_enz_sub"].sel({"enz_sub": enz_sub})
    return (
        get_log_km_brenda_blk(posterior, ec4, organism, substrate) + a_enz_sub
    )


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

with st.form("my_form"):
    with st.sidebar:
        db = st.selectbox("Dataset", ["BRENDA"])
        posterior = load_draws(db)
        summary_df = load_summary(db)
        # get selectbox options
        organism_options = ["unknown"] + posterior.coords[
            "biology_organism"
        ].to_series().unique().tolist()
        organism = st.selectbox("Organism", organism_options)
        remaining_biologies = [
            b
            for b in posterior.coords["biology"].to_series().unique().tolist()
            if b.split("|")[0] == organism
        ]
        remaining_ec4s = [s.split("|")[1] for s in remaining_biologies]
        ec4_options = ["unknown"] + remaining_ec4s
        ec4 = st.selectbox("EC4", ec4_options)
        remaining_biologies = [
            b for b in remaining_biologies if b.split("|")[1] == ec4
        ]
        ix_sub = 2 if db == "BRENDA" else 3
        remaining_substrates = [
            s.split("|")[ix_sub] for s in remaining_biologies
        ]
        substrate_options = ["unknown"] + remaining_substrates
        substrate = st.selectbox("Substrate", substrate_options)
        ec4_sub = (
            f"{ec4}|{substrate}"
            if not any("unknown" in s for s in [ec4, substrate])
            else "unknown"
        )
        org_sub = (
            f"{organism}|{substrate}"
            if not any("unknown" in s for s in [organism, substrate])
            else "unknown"
        )
        if db == "SABIO-RK":
            remaining_biologies = [
                b
                for b in remaining_biologies
                if b.split("|")[ix_sub] == substrate
            ]
            remaining_uniprots = [s.split("|")[2] for s in remaining_biologies]
            uniprot_options = ["unknown"] + remaining_uniprots
            uniprot = st.selectbox("Uniprot id", uniprot_options)
            enz_sub = (
                f"{uniprot}|{substrate}"
                if not any("unknown" in s for s in [uniprot, substrate])
                else "unknown"
            )
        biology_components = (
            [organism, ec4, substrate]
            if db == "BRENDA"
            else ["organism", "ec4", "uniprot", "substrate"]
        )
        biology = "|".join(biology_components)
        # get draws
        log_km = (
            posterior["mu"]
            + posterior["a_substrate"].sel({"substrate": substrate})
            + posterior["a_ec4_sub"].sel({"ec4_sub": ec4_sub})
            + posterior["a_org_sub"].sel({"org_sub": org_sub})
        )
        submitted = st.form_submit_button("Update the graph!")

        # Download links
        st.markdown(
            get_table_download_link(
                summary_df,
                "Download a csv table of model results.",
                "posterior_summary.csv",
            ),
            unsafe_allow_html=True,
        )
        st.write(
            "See [here](https://github.com/biosustain/km-stats) for the "
            "model's source code and for instructions to reproduce the "
            "full posterior distribution."
        )
    if submitted:
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
            alt.Chart(kde_df_bulk)
            .mark_area()
            .encode(x="log km", y="Posterior density")
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
