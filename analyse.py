"""Script for drawing graphs once main results are generated."""

import os

import arviz as az
import pandas as pd

from prepare_data import PREPARED_DIR
from src.analysis import (
    plot_cofactor_effects,
    plot_cofactor_substrate_comparison,
    plot_log_km_comparison,
    plot_nadh_comparison,
    plot_ppc,
    plot_vars,
)

RUNS_DIR = os.path.join("results", "runs")
RUN_DIRS = [
    p
    for p in map(lambda d: os.path.join(RUNS_DIR, d), os.listdir(RUNS_DIR))
    if os.path.isdir(p)
]
MODEL_CONFIGS = ["sabio-enz", "brenda-blk"]


def main():
    """Draw some graphs and print some log likelihood scores."""
    # load data
    posteriors, priors = (
        {
            mc: az.from_netcdf(os.path.join(RUNS_DIR, mc, f"{runtype}.nc"))
            for mc in MODEL_CONFIGS
        }
        for runtype in ["posterior", "prior"]
    )
    dfs = {
        "sabio": pd.read_csv(os.path.join(PREPARED_DIR, "sabio", "lits.csv")),
        "brenda": pd.read_csv(os.path.join(PREPARED_DIR, "brenda", "lits.csv")),
    }
    # Cross validation results
    for mc in MODEL_CONFIGS:
        llik_oos = az.extract_dataset(
            posteriors[mc], group="log_likelihood", var_names=["llik_oos"]
        )["llik_oos"]
        avg = float(llik_oos.mean())
        print(
            "Average out-of-sample log likelihood for model configuration "
            f"{mc}: {round(avg, 3)}"
        )

    # Draw ppc plots
    for mc, posterior in posteriors.items():
        f = plot_ppc(posterior)
        f.savefig(os.path.join("results", "plots", f"ppc_{mc}.png"))

    for mc, prior in priors.items():
        f = plot_ppc(prior)
        f.savefig(os.path.join("results", "plots", f"ppc_prior_{mc}.png"))

    # compare the sd parameter
    f = plot_vars(priors["sabio-enz"], vars=["tau", "sigma"])
    f.savefig(os.path.join("results", "plots", "sd_priors_sabio-enz.png"))
    f = plot_vars(posteriors["sabio-enz"], vars=["tau", "sigma"])
    f.savefig(os.path.join("results", "plots", "sd_posteriors_sabio-enz.png"))
    # f = plot_vars(posterior_blk, vars=["tau", "sigma"])
    # f.savefig(os.path.join("results", "plots", "sd_posteriors_blk.png"))

    # nadh comparison
    f = plot_nadh_comparison(posteriors["sabio-enz"].posterior, dfs["sabio"])
    f.savefig(os.path.join("results", "plots", "nadh_sabio-enz.png"))

    # log km comparison
    f = plot_log_km_comparison(
        {
            "sabio": posteriors["sabio-enz"].posterior,
            "brenda": posteriors["brenda-blk"].posterior,
        }
    )
    f.savefig(os.path.join("results", "plots", "log_km_comparison.png"))

    # cofactors
    f = plot_cofactor_effects(posteriors["sabio-enz"])
    f.savefig(
        os.path.join("results", "plots", "cofactor_effects_sabio-enz.png")
    )

    f = plot_cofactor_substrate_comparison(
        posteriors["sabio-enz"], dfs["sabio"]
    )
    f.savefig(
        os.path.join(
            "results", "plots", "cofactor_substrate_comparison_sabio-enz.png"
        )
    )


if __name__ == "__main__":
    main()
