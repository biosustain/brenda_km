"""Script for drawing graphs after running sample.py"""

import os

import arviz as az
import pandas as pd
from arviz.data.inference_data import InferenceData
from xarray.core.dataset import Dataset

from prepare_data import PREPARED_DIR
from src.analysis import (
    plot_concentration_comparison,
    plot_log_km_comparison,
    plot_nadh_comparison,
    plot_oos_cv,
    plot_ppc,
    plot_vars,
)

RUN_DIR_PARENT = os.path.join("results", "runs")
RUN_DIRS = list(
    filter(
        os.path.isdir,
        [os.path.join(RUN_DIR_PARENT, d) for d in os.listdir(RUN_DIR_PARENT)],
    )
)


def flatten_columns(df: pd.DataFrame, sep="_") -> pd.DataFrame:
    """Flatten the columns of a dataframe.

    This is nice to do because in my opinion MultiIndexes are often quite
    annoying.

    """
    assert isinstance(
        df.columns, pd.MultiIndex
    ), "Not enough levels to flatten!"
    new_column_values = df.columns.get_level_values(0)
    new_columns_name = df.columns.names[0]
    for i in range(len(df.columns.levels) - 1):
        iplusone_vals = df.columns.get_level_values(i + 1)
        iplusone_name = df.columns.names[i + 1]
        new_column_values = [
            f"{v_i}{sep}{v_iplusone}"
            for v_i, v_iplusone in zip(new_column_values, iplusone_vals)
        ]
        new_columns_name = f"{new_columns_name}{sep}{iplusone_name}"
    new_columns = pd.Index(new_column_values, name=new_columns_name)
    return pd.DataFrame(df, columns=new_columns)


def load_df(f):
    out = pd.read_csv(f)
    assert isinstance(out, pd.DataFrame)
    return out


def load_idata(f):
    out = az.from_netcdf(f)
    assert isinstance(out, az.InferenceData)
    return out


def get_log_likelihood(idata: InferenceData) -> Dataset:
    out = idata.get("log_likelihood")
    assert isinstance(out, Dataset)
    return out


def main():
    # load data
    priors = {
        os.path.basename(d): load_idata(os.path.join(d, "prior.nc"))
        for d in RUN_DIRS
    }
    posteriors = {
        os.path.basename(d): load_idata(os.path.join(d, "posterior.nc"))
        for d in RUN_DIRS
    }
    dfs = {
        "sabio": load_df(os.path.join(PREPARED_DIR, "sabio_km", "lits.csv")),
        "brenda": load_df(os.path.join(PREPARED_DIR, "brenda_km", "lits.csv")),
        "sabio_concs": load_df(os.path.join(PREPARED_DIR, "sabio_concs.csv")),
    }
    prior_enz = priors["sabio-km-enz"].get("posterior")
    prior_rs = priors["sabio-km-really-simple"].get("posterior")
    posterior_enz = posteriors["sabio-km-enz"].get("posterior")
    posterior_brenda = posteriors["brenda-km-blk"].get("posterior")
    posterior_blk = posteriors["sabio-km-blk"].get("posterior")

    # Ensure that posterior_km has the right type (mainly to shut up the checker...)
    assert isinstance(posterior_enz, Dataset)
    assert isinstance(posterior_blk, Dataset)
    assert isinstance(posterior_brenda, Dataset)
    assert isinstance(prior_enz, Dataset)
    assert isinstance(prior_rs, Dataset)

    # Cross validation results
    ooss = {
        name: az.extract_dataset(
            idata, group="log_likelihood", var_names=["llik_oos"]
        )["llik_oos"]
        for name, idata in posteriors.items()
        if "llik_oos" in get_log_likelihood(idata).data_vars
    }
    for name, oos in ooss.items():
        avg = float(oos.mean())
        print(
            f"Average out-of-sample log likelihood for model {name}: {round(avg, 3)}"
        )

    # Cross validation plot
    f = plot_oos_cv(
        {"blk": posteriors["sabio-km-blk"], "final": posteriors["sabio-km-enz"]}
    )
    f.savefig(os.path.join("results", "plots", "cv.png"))

    # Draw ppc plots
    for run_name, posterior in posteriors.items():
        f = plot_ppc(posterior)
        f.savefig(os.path.join("results", "plots", f"ppc_{run_name}.png"))

    for run_name, prior in priors.items():
        f = plot_ppc(prior)
        f.savefig(os.path.join("results", "plots", f"ppc_prior_{run_name}.png"))

    # compare the sd parameter
    f = plot_vars(prior_enz, vars=["tau", "sigma"])
    f.savefig(os.path.join("results", "plots", "sd_priors_enz.png"))
    f = plot_vars(posterior_enz, vars=["tau", "sigma"])
    f.savefig(os.path.join("results", "plots", "sd_posteriors_enz.png"))
    f = plot_vars(posterior_blk, vars=["tau", "sigma"])
    f.savefig(os.path.join("results", "plots", "sd_posteriors_blk.png"))

    # nadh comparison
    f = plot_nadh_comparison(posterior_enz, dfs["sabio"])
    f.savefig(os.path.join("results", "plots", "nadh.png"))

    # log km comparison
    f = plot_log_km_comparison(
        {"SABIO": posterior_enz, "BRENDA": posterior_brenda}
    )
    f.savefig(os.path.join("results", "plots", "log_km_comparison.png"))
    f = plot_log_km_comparison({"b-enz": prior_enz, "a-rs": prior_rs})
    f.savefig(os.path.join("results", "plots", "log_km_comparison_prior.png"))

    # concentration comparison
    f = plot_concentration_comparison(posterior_enz, dfs["sabio_concs"])
    f.savefig(os.path.join("results", "plots", "concentration_comparison.png"))


if __name__ == "__main__":
    main()
