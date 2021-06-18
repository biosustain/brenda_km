from typing import List
import os
from altair.vegalite.v4.schema.channels import Opacity
from scipy.stats.kde import gaussian_kde
import streamlit as st
import numpy as np
import pandas as pd
import arviz as az
import altair as alt
from src.stan_io import get_all_predictors

def get_lit_link(e: str, l: str) -> str:
    lit = l.replace("[", "").replace("]", "")
    url = f"https://www.brenda-enzymes.org/literature.php?e={e}&r={lit}"
    return f'<a href = "{url}">{lit}</a>'

def get_obs(
    msmts: pd.DataFrame, organism: str, ec4: str, substrate: str
) -> pd.DataFrame:
    obs = (
        msmts
        .set_index(["organism", "ec4", "substrate"])
        .loc[(organism, ec4, substrate)]
        .rename(columns={"log_km": "log km"})
    )
    obs["Posterior density"] = 0
    obs["reference"] = [get_lit_link(row["ec4"], row["literature"]) for _, row in obs.reset_index().iterrows()]
    return obs

def get_samples(infd, msmts, organism, ec4, substrate) -> pd.Series:
    predictors = get_all_predictors(msmts)
    is_natural = (
        msmts.groupby(["organism", "ec4", "substrate"])["is_natural"].first()
        .loc[(organism, ec4, substrate)]
    )
    ix = pd.MultiIndex.from_frame(predictors)
    predictor_to_predictor_id = pd.Series(range(len(ix)), index=ix)
    ec3 = ".".join(ec4.split(".")[:3])
    predictor_ix = predictor_to_predictor_id.loc[(organism, ec3, ec4, is_natural)]
    return (
        infd.posterior["yhat"]
        .sel({"predictor_ix": predictor_ix})
        .to_series()
        .values
    )

NC_FILE = os.path.join("results", "infd", "app_infd.nc")
MEASUREMENTS_FILE = os.path.join("data", "prepared", "data_prepared.csv")

msmts = pd.read_csv(MEASUREMENTS_FILE)
infd = az.from_netcdf(NC_FILE)

# Start of app
st.title("What does BRENDA say?")

st.write("""
This webapp shows marginal posterior distributions for Km parameters from a model we trained on data from the [BRENDA database](https://www.brenda-enzymes.org/).
""")

st.write("The graph shows the posterior distribution (blue) and experimental measurements (red). Below is a table with information about the measurements.")

st.sidebar.write("Choose which marginal posterior distribution you'd like to see!")
organism = st.sidebar.selectbox("Organism", msmts["organism"].unique())
ec4 = st.sidebar.selectbox("EC4", msmts.groupby("organism")["ec4"].unique().loc[organism])
substrate = st.sidebar.selectbox("Substrate", msmts.groupby(["organism", "ec4"])["substrate"].unique().loc[(organism, ec4)])

samples = get_samples(infd, msmts, organism, ec4, substrate)
low, median, high = np.quantile(samples, [0.025, 0.5, 0.975])
sd = samples.std()
obs = get_obs(msmts, organism, ec4, substrate)

kde = gaussian_kde(samples)
x = np.linspace(samples.min() - 0.1, samples.max() + 0.1, 100)
is_bulk = (x > low) & (x < high)
y = kde(x)
kde_df = pd.DataFrame({"log km": x, "Posterior density": y})
kde_df_bulk = kde_df.copy().assign(**{"log km": kde_df["log km"].where(is_bulk)})
median_df = pd.DataFrame({"log km": median}, index=[0])

kde_chart = alt.Chart(kde_df).mark_area(opacity=0.2).encode(x="log km", y="Posterior density")
kde_chart_bulk = alt.Chart(kde_df_bulk).mark_area().encode(x="log km", y="Posterior density")
dots = alt.Chart(obs).mark_point(color="red").encode(x="log km", y="Posterior density", tooltip=["literature", "temperature", "km", "log km"])
rule = alt.Chart(median_df).mark_rule(color="black").encode(x="log km")

col1, col2 = st.beta_columns([3, 2])

col1.altair_chart(kde_chart + kde_chart_bulk + dots + rule)
col2.write(
    f"Posterior median: {round(median, 2)}"
    f"\n\nPosterior standard deviation: {round(sd, 2)}"
    f"\n\n2.5% posterior quantile: {round(low, 2)}"
    f"\n\n97.5% posterior quantile: {round(high, 2)}"
)
st.write(obs.reset_index()[["reference", "is_natural", "temperature", "km", "log km"]].to_html(escape=False), unsafe_allow_html=True)

