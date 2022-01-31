"""Functions for analysis some results."""

from typing import List

import arviz as az
import numpy as np
import pandas as pd
from arviz.plots.forestplot import plot_forest
from matplotlib import pyplot as plt
from matplotlib.figure import Figure
from xarray.core.dataset import Dataset

from src.data_preparation import check_is_df


def plot_vars(posterior: Dataset, vars: List[str]) -> Figure:
    var_regex = "|".join(vars)
    plot_forest(
        posterior,
        filter_vars="regex",
        var_names=var_regex,
        ridgeplot_kind="hist",
        combined=True,
        kind="ridgeplot",
        hdi_prob=0.999,
    )
    f = plt.gcf()
    ax = plt.gca()
    ax.set_xlabel("Parameter value")
    ax.set_ylabel("Posterior density")
    f.suptitle(
        "Comparison of marginal distributions for standard deviation parameters"
    )
    return f


def plot_nadh_comparison(posterior: Dataset, lits: pd.DataFrame) -> Figure:
    samples = (
        posterior["log_km"]
        .to_dataframe()
        .rename(columns={"biology_substrate": "substrate"})
    )
    assert isinstance(samples, pd.DataFrame)
    is_nadh = lambda df: df["substrate"] == "NADH"
    is_nadph = lambda df: df["substrate"] == "NADPH"
    f, axes = plt.subplots(1, 2, figsize=[12, 6], sharex=True)
    axes = axes.ravel()
    f.suptitle(
        "Comparison of measured and modelled Km parameters for NADH and NADPH"
    )
    axes[0].set_title("Measurements")
    axes[1].set_title("Posterior samples")
    for ax, df, bins, title, ycol in zip(
        axes,
        (lits, samples),
        (25, 100),
        ("Measurements", "Posterior samples"),
        ("y", "log_km"),
    ):
        ax.set_title(title)
        ax.hist(df.loc[is_nadh, ycol], alpha=0.6, label="nadh", bins=bins)
        ax.hist(df.loc[is_nadph, ycol], alpha=0.6, label="nadph", bins=bins)
        ax.set_xlabel("Km value ($\\ln$ scale)")
        ax.set_ylabel("Frequency")
        ax.legend(frameon=False)
    plt.tight_layout()
    return f


def plot_log_km_comparison(
    posterior_sabio: Dataset, posterior_brenda: Dataset
) -> Figure:
    posteriors = posterior_sabio, posterior_brenda
    names = ["SABIO-RK", "BRENDA"]
    colors = ["tab:blue", "tab:orange"]
    f, axes = plt.subplots(1, 2, figsize=[15, 5])
    axes = axes.ravel()
    bins = np.linspace(0, 20, 50)
    xlow, xhigh = axes[1].get_xlim()
    for posterior, name, color in zip(posteriors, names, colors):
        qs = check_is_df(
            check_is_df(
                posterior["log_km"]
                .quantile([0.01, 0.5, 0.99], dim=["chain", "draw"])
                .to_series()
                .unstack("quantile")
                .rename(columns={0.01: "low", 0.5: "med", 0.99: "high"})
            )
            .assign(width=lambda df: df["high"].subtract(df["low"]))
            .sort_values("med")
        )
        axes[0].hist(
            qs["width"], bins=bins, label=name, density=True, alpha=0.6
        )
        x = np.linspace(xlow, xhigh, len(qs))
        axes[1].vlines(
            x,
            qs["low"],
            qs["high"],
            color=color,
            zorder=0,
            label=name,
            linewidths=0.05,
        )
    axes[0].set_title(
        "Histograms of 1%-99% $\\ln$ scale marginal Km distribution widths"
    )
    axes[1].set_title("1%-99% $\\ln$ scale marginal Km distributions")
    axes[1].set_xticks([])
    axes[1].set_ylabel("Km value, $\\ln$ scale")
    axes[0].legend(frameon=False)
    axes[1].legend(frameon=False)
    plt.tight_layout()
    return f


def plot_concentration_comparison(
    posterior: Dataset, conc: pd.DataFrame
) -> Figure:
    biology_cols = [
        "Organism",
        "ECNumber",
        "UniprotID",
        "parameter.associatedSpecies",
    ]
    conc_mean = pd.Series(
        pd.Series(
            conc.assign(
                biology=(conc[biology_cols].astype(str).apply("|".join, axis=1))
            )
            .groupby("biology", dropna=False)
            .apply(lambda df: df["concentration_mM"].pipe(np.log).mean())
        ).rename("sabio_mean_conc")
    )
    log_km = posterior["log_km"].to_dataframe()
    log_km_resid = log_km.join(conc_mean, on="biology", how="inner").assign(
        resid=lambda df: df["log_km"] - df["sabio_mean_conc"]
    )
    bins = np.linspace(-15, 14, 60)
    f, axes = plt.subplots(1, 2, figsize=[15, 5], sharex=True)
    axes[0].hist(
        log_km["log_km"],
        bins=bins,
        density=True,
        label="Posterior samples",
        alpha=0.6,
    )
    axes[0].hist(
        conc_mean,
        bins=bins,
        density=True,
        label="Reported concentrations",
        alpha=0.6,
    )
    axes[0].set(
        title="Marginal distributions",
        xlabel="$\\ln$ Km or $\\ln$ concentraion (mM)",
    )
    axes[0].legend(frameon=False)
    axes[1].hist(
        log_km_resid["resid"],
        bins=bins,
        label="$\\ln$ Km posterior sample - average sabio concentration",
        density=True,
    )
    axes[1].axvline(0, color="red")
    axes[1].set(
        title="Differences", xlabel="$\\ln$ Km - $\\ln$ concentration (mM)"
    )
    return f


def generate_summary_df(idata: az.InferenceData):
    posterior = idata.get("posterior")
    cd = ["chain", "draw"]
    assert isinstance(posterior, Dataset)
    quantiles = (
        posterior["log_km"]
        .quantile([0.01, 0.5, 0.99], dim=cd)
        .to_series()
        .unstack("quantile")
        .add_prefix("q_")
    )
    mean = (
        posterior["log_km"]
        .mean(dim=cd)
        .to_dataframe()
        .rename(columns={"log_km": "posterior_mean"})
    )
    assert isinstance(mean, pd.DataFrame)
    return mean.join(quantiles).reset_index()


import arviz as az
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from xarray.core.dataset import Dataset


def normalise_zero_one(x):
    min_val, max_val = np.min(x), np.max(x)
    return (x - min_val) / (max_val - min_val)


# log_km_low = (
#     posterior["log_km"]
#     .rename("log_km_low")
#     .quantile(0.01, dim=cd)
#     .to_dataframe()
# )
# log_km_high = (
#     posterior["log_km"].rename("log_km_high").quantile(0.99, dim=cd).to_series()
# )
# km = log_km_low.join(log_km_high).join(
#     conc_mean,
#     on=[
#         "biology_organism",
#         "biology_substrate",
#         "biology_ec4",
#         "biology_uniprot_id",
#     ],
#     how="inner",
# )
# km["posterior_precision"] = 1 - normalise_zero_one(
#     km["log_km_high"] - km["log_km_low"]
# )
# reports = check_is_df(pd.read_csv("data/prepared/sabio_km/reports.csv"))

# y = reports.join(km[["sabio_mean_conc"]], on="biology", how="inner")
# f, ax = plt.subplots(figsize=[12, 8])
# ax.vlines(
#     km["sabio_mean_conc"],
#     km["log_km_low"],
#     km["log_km_high"],
#     alpha=km["posterior_precision"],
# )
# ax.plot(km["sabio_mean_conc"], km["sabio_mean_conc"])
# ax.scatter(y["sabio_mean_conc"], y["y"], s=3)
