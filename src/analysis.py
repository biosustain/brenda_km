"""Functions for analysis some results."""

from typing import List

import numpy as np
import pandas as pd
from arviz.plots.forestplot import plot_forest
from matplotlib import pyplot as plt
from matplotlib.figure import Figure
from xarray.core.dataset import Dataset


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
    samples = posterior["log_km"].to_series().reset_index()
    is_nadh = lambda df: df["biology"].str.endswith("NADH")
    is_nadph = lambda df: df["biology"].str.endswith("NADPH")
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
        ax.set_xlabel("Km value ($\ln$ scale)")
        ax.set_ylabel("Frequency")
        ax.legend(frameon=False)
    plt.tight_layout()
    return f


def plot_log_km_comparison(
    posterior_sabio: Dataset,
    posterior_brenda: Dataset,
    lits_sabio: pd.DataFrame,
    lits_brenda: pd.DataFrame,
) -> Figure:
    posteriors = posterior_sabio, posterior_brenda
    datasets = lits_sabio, lits_brenda
    titles = ["SABIO-RK", "BRENDA"]
    f, axes = plt.subplots(1, 2, figsize=[15, 5], sharey=True)
    axes = axes.ravel()
    for posterior, df, ax, title in zip(posteriors, datasets, axes, titles):
        qs = (
            posterior["log_km"]
            .quantile([0.01, 0.5, 0.99], dim=["chain", "draw"])
            .to_series()
            .unstack("quantile")
            .rename(columns={0.01: "low", 0.5: "med", 0.99: "high"})
            .sort_values("med")
        )
        xlow, xhigh = ax.get_xlim()
        x = np.linspace(xlow, xhigh, len(qs))
        df_x = pd.Series(x, index=qs.index).reindex(df["biology"])
        ax.vlines(
            x,
            qs["low"],
            qs["high"],
            color="tab:blue",
            zorder=0,
            label="1%-99% posterior interval",
        )
        # ax.scatter(df_x, df["y"], color="black", s=5, label="Measured value")
        ax.set_title(title)
        ax.set_xticks([])
        ax.set_ylabel("Km value, $\ln$ scale")
        ax.legend(frameon=False)
    plt.tight_layout()
    return f
