"""Draw some plots to analyse the model results."""

import os

import arviz as az
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt

NC_FILE = os.path.join("results", "infd", "app_infd.nc")
CSV_FILE = os.path.join("data", "prepared", "data_prepared.csv")
PLOT_DIR = os.path.join("results", "plots")


def main():
    infd = az.from_netcdf(NC_FILE)
    m = pd.read_csv(CSV_FILE)
    loo = az.loo(infd, pointwise=True)
    khats = loo.pareto_k
    yrep_qs = (
        infd.posterior_predictive["yrep"]
        .quantile([0.025, 0.5, 0.975], dim=["chain", "draw"])
        .to_series()
        .unstack("quantile")
    )

    m["khat"] = khats
    m["yrep_low"] = yrep_qs[0.025]
    m["yrep_med"] = yrep_qs[0.5]
    m["yrep_high"] = yrep_qs[0.975]

    p = m.copy().sort_values(["yrep_med"])
    x = np.linspace(0, 1, len(p))

    f, ax = plt.subplots()
    ax.scatter(
        x,
        p["log_km"].values,
        cmap="viridis",
        s=5,
        alpha=0.5,
        c=p["khat"].values,
        label="BRENDA",
    )
    ax.vlines(
        x,
        p["yrep_low"],
        p["yrep_high"],
        zorder=0,
        color="gainsboro",
        label="95% CI",
    )
    ax.set_xticks([], [])
    ax.set_ylabel("log_km")
    ax.legend(frameon=False)
    f.savefig(os.path.join(PLOT_DIR, "predictions.png"), bbox_inches="tight")

    ax = az.plot_forest(infd, var_names=["tau_predictor"], transform=np.log)
    plt.gcf().savefig(os.path.join(PLOT_DIR, "tau_predictor.png"), bbox_inches="tight")

if __name__ == "__main__":
    main()
