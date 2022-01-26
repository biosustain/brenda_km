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
        qs = (
            posterior["log_km"]
            .quantile([0.01, 0.5, 0.99], dim=["chain", "draw"])
            .to_series()
            .unstack("quantile")
            .rename(columns={0.01: "low", 0.5: "med", 0.99: "high"})
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
        "Histograms of 1%-99% $\ln$ scale marginal Km distribution widths"
    )
    axes[1].set_title("1%-99% $\ln$ scale marginal Km distributions")
    axes[1].set_xticks([])
    axes[1].set_ylabel("Km value, $\ln$ scale")
    axes[0].legend(frameon=False)
    axes[1].legend(frameon=False)
    plt.tight_layout()
    return f
