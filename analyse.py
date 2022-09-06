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
MODEL_CONFIGS = [
    "sabio-enz",
    "brenda-blk",
    "sabio-simple",
    "brenda-simple",
    "sabio-blk",
    "sabio-really-simple",
    "brenda-really-simple",
]


def main():
    """Draw some graphs and print some log likelihood scores."""
    # load data
    posteriors, priors, llik_cvs = (
        {
            mc: az.from_json(os.path.join(RUNS_DIR, mc, f"{runtype}.json"))
            for mc in MODEL_CONFIGS
            if os.path.exists(os.path.join(RUNS_DIR, mc, f"{runtype}.json"))
        }
        for runtype in ["posterior", "prior", "llik_cv"]
    )
    dfs = {
        "sabio": pd.read_csv(os.path.join(PREPARED_DIR, "sabio", "lits.csv")),
        "brenda": pd.read_csv(os.path.join(PREPARED_DIR, "brenda", "lits.csv")),
    }
    # Cross validation results
    for mc in MODEL_CONFIGS:
        if mc in llik_cvs.keys():
            llik_oos = az.extract_dataset(
                llik_cvs[mc], group="posterior", var_names=["llik"]
            )["llik"]
            avg = float(llik_oos.mean())
            print(
                "Average out-of-sample log likelihood for model configuration "
                f"{mc}: {round(avg, 3)}"
            )

    # Draw ppc plots
    for mc, posterior in posteriors.items():
        f = plot_ppc(posterior)
        f.suptitle(f"{mc} model marginal posterior predictive intervals")
        f.savefig(os.path.join("results", "plots", f"ppc_{mc}.png"))

    for mc, prior in priors.items():
        f = plot_ppc(prior)
        f.suptitle(f"{mc} model marginal prior predictive intervals")
        f.savefig(os.path.join("results", "plots", f"ppc_prior_{mc}.png"))

    # compare the lognormal parameters
    ln_params = ["tau", "sigma"]
    for mc in MODEL_CONFIGS:
        for fits, mode in zip([priors, posteriors], ["prior", "posterior"]):
            f = plot_vars(fits[mc], vars=ln_params)
            ds = mc.split("-")[0].upper()
            f.suptitle(
                f"Comparison of {ds} model {mode}s for log-normal parameters"
            )
            f.savefig(os.path.join("results", "plots", f"ln_{mode}s_{mc}.png"))

    # nadh comparison
    f = plot_nadh_comparison(posteriors["brenda-blk"].posterior, dfs["brenda"])
    f.suptitle(
        "Comparison of measured and modelled Km parameters for NADH and NADPH: "
        "BRENDA model"
    )
    f.tight_layout()
    f.savefig(os.path.join("results", "plots", "nadh_brenda-blk.png"))
    f = plot_nadh_comparison(posteriors["sabio-enz"].posterior, dfs["sabio"])
    f.suptitle(
        "Comparison of measured and modelled Km parameters for NADH and NADPH: "
        "SABIO-RK model"
    )
    f.tight_layout()
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
    f = plot_cofactor_effects(posteriors["brenda-blk"])
    f.suptitle("1%-99% posterior intervals for substrate effects: BRENDA model")
    f.savefig(
        os.path.join("results", "plots", "cofactor_effects_brenda-blk.png")
    )
    f = plot_cofactor_effects(posteriors["sabio-enz"])
    f.suptitle("1%-99% posterior intervals for substrate effects: SABIO-RK model")
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
