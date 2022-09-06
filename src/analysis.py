"""Functions for analysis some results."""

from typing import Dict, List

import arviz as az
import numpy as np
import pandas as pd
from arviz.data.inference_data import InferenceData
from arviz.plots.forestplot import plot_forest
from matplotlib import pyplot as plt
from matplotlib.figure import Figure
from xarray.core.dataset import Dataset

from src.data_preparation import COFACTORS  # type: ignore


def plot_vars(posterior: Dataset, vars: List[str]) -> Figure:
    """Plot some variables."""
    var_regex = "|".join(vars)
    plot_forest(
        posterior,
        kind="ridgeplot",
        filter_vars="regex",
        var_names=var_regex,
        ridgeplot_quantiles=None,
        ridgeplot_truncate=False,
        combined=True,
        hdi_prob=0.999,
        figsize=[12, 8],
    )
    f = plt.gcf()
    ax = plt.gca()
    ax.set_xlabel("Parameter value")
    ax.set_ylabel("Posterior density")
    return f


def plot_nadh_comparison(posterior: Dataset, lits: pd.DataFrame) -> Figure:
    """Compare nadh and nadph kms."""
    samples = (
        posterior["log_km"]
        .to_dataframe()
        .rename(columns={"biology_substrate": "substrate"})
        .join(lits.groupby("biology")["substrate"].first(), on="biology")
    )
    f, axes = plt.subplots(2, 2, figsize=[12, 6], sharex=True)
    for row, substrates in zip([0, 1], [("NADH", "NAD+"), ("NADPH", "NADP+")]):
        axes[row, 0].set_title("Measurements")
        axes[row, 1].set_title("Posterior samples")
        for ax, df, bins, title, ycol in zip(
            axes[row],
            (lits, samples),
            (25, 100),
            ("Measurements", "Posterior samples"),
            ("y", "log_km"),
        ):
            ax.set_title(title)
            for s in substrates:
                ax.hist(
                    df.loc[lambda df: df["substrate"] == s, ycol],
                    alpha=0.6,
                    label=s,
                    bins=bins,
                    density=True,
                )
                ax.set_xlabel("Km value ($\\ln$ scale)")
                ax.set_ylabel("Relative frequency")
                ax.legend(frameon=False)
    plt.tight_layout()
    return f


def plot_log_km_comparison(ds_dict: Dict[str, Dataset]) -> Figure:
    """Compare log kms."""
    posteriors = ds_dict.values()
    names = ds_dict.keys()
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
            zorder=-1,
            label=name,
            linewidths=0.05,
            alpha=0.5,
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


def plot_ppc(idata: InferenceData) -> Figure:
    """Do a posterior predictive check plot."""
    posterior = idata.get("posterior")
    observed_data = idata.get("observed_data")
    assert isinstance(posterior, Dataset)
    assert isinstance(observed_data, Dataset)
    df = (
        posterior["yrep"]
        .quantile([0.01, 0.1, 0.5, 0.9, 0.99], dim=["chain", "draw"])
        .to_series()
        .unstack("quantile")
        .add_prefix("q_")
    )
    assert isinstance(df, pd.DataFrame)
    df["obs"] = observed_data["y"].values
    df = df.sort_values("q_0.5")
    f, ax = plt.subplots(figsize=[12, 5])
    x_low, x_high = ax.get_xlim()
    x = np.linspace(x_low, x_high, num=len(df))
    ax.vlines(
        x,
        df["q_0.01"],
        df["q_0.99"],
        alpha=0.6,
        zorder=-1,
        linewidth=0.1,
        label="1%-99% posterior predictive interval",
    )
    ax.vlines(
        x,
        df["q_0.1"],
        df["q_0.9"],
        zorder=1,
        linewidth=0.1,
        label="10%-90% posterior predictive interval",
    )
    ax.scatter(x, df["obs"], color="black", s=1, zorder=2)
    ax.set_ylabel("Km value ($\\ln$ scale)")
    ax.set_xlabel("Measurement (ordered by posterior predictive median)")
    ax.set_yticks(
        ax.get_yticks(), ["%.2g" % t for t in np.exp(ax.get_yticks())]
    )
    ax.set_xticklabels([])
    ax.set_xticklabels([])
    return f


def plot_concentration_comparison(
    posterior: Dataset, conc: pd.DataFrame
) -> Figure:
    """Compare physiological concentrations with kms."""
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


def generate_summary_df(posterior: Dataset):
    """Get a log km summary dataframe from a Dataset."""
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


def plot_oos_cv(idatas: Dict[str, InferenceData]) -> Figure:
    """Show out-of-sample cross-validation results."""
    f, ax = plt.subplots(figsize=[12, 6])
    bins = np.linspace(-10, 0, 100)
    for name, idata in idatas.items():
        llik = idata.get("log_likelihood")
        assert isinstance(llik, Dataset)
        if "llik_oos" in llik.data_vars:
            oos = az.extract_dataset(
                idata, group="log_likelihood", var_names=["llik_oos"]
            )
            ax.hist(
                oos["llik_oos"].to_series().dropna(),
                bins=bins,
                alpha=0.6,
                density=True,
                label=name,
            )
            ax.legend(frameon=False)
    ax.set(
        title="Comparison of out-of-sample log likelihoods",
        xlabel="log likelihood",
        ylabel="Relative frequency",
    )
    return f


def plot_cofactor_effects(posterior: InferenceData) -> Figure:
    """Visualise cofactor effects."""
    a_sub_qs = (
        az.extract_dataset(posterior, var_names="a_substrate", combined=True)
        .quantile([0.01, 0.5, 0.99], dim="sample")
        .to_dataframe()
        .unstack("quantile")["a_substrate"]
        .drop("unknown", axis=0)
        .sort_values(0.5)
    )
    f, ax = plt.subplots(figsize=[12, 5])
    xlim_low, xlim_high = ax.get_xlim()
    x = pd.Series(
        np.linspace(xlim_low, xlim_high, num=len(a_sub_qs)),
        index=a_sub_qs.index,
    )
    ax.vlines(
        x.values,
        a_sub_qs[0.01],
        a_sub_qs[0.99],
        linewidth=0.1,
        label="Other substrate",
    )
    ax.vlines(
        x.loc[COFACTORS].values,
        a_sub_qs.loc[COFACTORS, 0.01],
        a_sub_qs.loc[COFACTORS, 0.99],
        color="red",
        label="Cofactor",
    )
    for c in COFACTORS:
        ax.annotate(c, [x.loc[c], a_sub_qs.loc[c, 0.01]], fontsize=7)
    ax.set_xticks([])
    ax.legend(frameon=False)
    ax.set(ylabel="Parameter values")
    return f


def plot_cofactor_substrate_comparison(
    posterior: InferenceData, lits: pd.DataFrame
) -> Figure:
    """Compare posterior means of cofactors and substrates."""
    log_kms = az.extract_dataset(posterior, var_names="log_km", combined=True)
    means = (
        log_kms.mean(dim="sample")
        .to_dataframe()
        .reset_index()
        .join(
            lits.rename(columns={"biology_substrate": "substrate"})
            .groupby("biology")[["substrate", "reaction_substrates"]]
            .first(),
            on="biology",
        )
        .assign(
            cofactor=lambda df: df["substrate"].isin(COFACTORS),
            bio_non_sub=lambda df: (
                df["biology"].str.split("|").apply(lambda s: "|".join(s[:3]))
            ),
        )
    )
    cofactor_means = (
        means.query("cofactor")
        .groupby(["bio_non_sub", "reaction_substrates"])[
            ["log_km", "substrate"]
        ]
        .first()
        .rename(columns={"log_km": "cofactor_mean", "substrate": "cofactor"})
        .pipe(pd.DataFrame)
    )
    other_means = (
        means.query("~cofactor")
        .groupby(["bio_non_sub", "reaction_substrates"])["log_km"]
        .apply(list)
        .explode()
        .rename("other_mean")
        .pipe(pd.DataFrame)
    )
    t = other_means.join(cofactor_means, how="inner")
    f, ax = plt.subplots(figsize=[12, 8])
    for cofactor, group in t.groupby("cofactor"):
        ax.scatter(
            group["cofactor_mean"], group["other_mean"], label=cofactor, s=5
        )
    ax.plot(t["cofactor_mean"], t["cofactor_mean"], c="red", label="x=y")
    ax.legend(frameon=False)
    ax.set(
        title="Comparison of posterior means: cofactor vs substrate",
        xlabel="$\\ln$ Km (Substrate)",
        ylabel="$\\ln$ Km (Cofactor)",
    )
    return f
