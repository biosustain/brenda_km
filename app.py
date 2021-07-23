from typing import List
import os
from altair.vegalite.v4.schema.channels import Opacity
from scipy.stats.kde import gaussian_kde
import streamlit as st
import numpy as np
import pandas as pd
import arviz as az
import altair as alt
from src.model_configuration import ModelConfiguration
from src.loading import get_cats, CAT_COLS


def get_lit_link(e: str, l: str) -> str:
    lit = l.replace("[", "").replace("]", "")
    url = f"https://www.brenda-enzymes.org/literature.php?e={e}&r={lit}"
    return f'<a href = "{url}">{lit}</a>'


def get_obs(
    msmts: pd.DataFrame, organism: str, ec4: str, substrate: str
) -> pd.DataFrame:
    obs = (
        msmts.set_index(["organism", "ec4", "substrate"])
        .loc[(organism, ec4, substrate)]
        .rename(columns={"log_km": "log km"})
    )
    obs["Posterior density"] = 0
    obs["reference"] = [
        get_lit_link(row["ec4"], row["literature"])
        for _, row in obs.reset_index().iterrows()
    ]
    return obs


def check_if_natural(
    msmts: pd.DataFrame, organism: str, ec4: str, substrate: str
) -> bool:
    return (
        msmts.groupby(["organism", "ec4", "substrate"])["is_natural"]
        .first()
        .loc[(organism, ec4, substrate)]
    )


# non-choice-dependent data
msmts = pd.read_csv(os.path.join("data", "prepared", "data_prepared.csv"))
idata = az.from_netcdf(os.path.join("results", "infd", "app_infd.nc"))
cats = get_cats(msmts, CAT_COLS)

# Start of app
st.title("What does BRENDA say?")

st.write(
    """
This webapp shows marginal posterior distributions for Km parameters from a model we trained on data from the [BRENDA database](https://www.brenda-enzymes.org/).
"""
)

st.write(
    "The graph shows the posterior distribution (blue) and experimental measurements (red). Below is a table with information about the measurements."
)

st.sidebar.write("Choose which marginal posterior distribution you'd like to see!")

# Get required data
organism = st.sidebar.selectbox("Organism", msmts["organism"].unique())
ec4 = st.sidebar.selectbox(
    "EC4", msmts.groupby("organism")["ec4"].unique().loc[organism]
)
substrate = st.sidebar.selectbox(
    "Substrate",
    msmts.groupby(["organism", "ec4"])["substrate"].unique().loc[(organism, ec4)],
)
is_natural = check_if_natural(msmts, organism, ec4, substrate)
ec3 = msmts.groupby("ec4")["ec3"].first().loc[ec4]
cat = "-".join([ec3, ec4, organism])
b_natural = idata.posterior["b_natural"]
a_cat = idata.posterior["a_cat"].sel({"cat": cat})
yhat = a_cat + b_natural if is_natural else a_cat
yhat = yhat.stack(chain_draw=["chain", "draw"])


low, median, high = yhat.quantile([0.025, 0.5, 0.975]).values
sd = float(yhat.std())
obs = get_obs(msmts, organism, ec4, substrate)

kde = gaussian_kde(yhat)
x = np.linspace(yhat.min() - 0.1, yhat.max() + 0.1, 100)
is_bulk = (x > low) & (x < high)
y = kde(x)
kde_df = pd.DataFrame({"log km": x, "Posterior density": y})
kde_df_bulk = kde_df.copy().assign(**{"log km": kde_df["log km"].where(is_bulk)})
median_df = pd.DataFrame({"log km": median}, index=[0])

kde_chart = (
    alt.Chart(kde_df).mark_area(opacity=0.2).encode(x="log km", y="Posterior density")
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
        tooltip=["literature", "temperature", "km", "log km"],
    )
)
rule = alt.Chart(median_df).mark_rule(color="black").encode(x="log km")

col1, col2 = st.beta_columns([3, 2])

col1.altair_chart(kde_chart + kde_chart_bulk + dots + rule)
col2.write(
    f"Posterior median: {median}"
    f"\n\nPosterior standard deviation: {round(sd, 2)}"
    f"\n\n2.5% posterior quantile: {round(low, 2)}"
    f"\n\n97.5% posterior quantile: {round(high, 2)}"
)
st.write(
    obs.reset_index()[
        ["reference", "is_natural", "temperature", "km", "log km"]
    ].to_html(escape=False),
    unsafe_allow_html=True,
)
