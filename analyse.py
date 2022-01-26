"""Script for drawing graphs after running sample.py"""

import os

import arviz as az
import pandas as pd
from xarray.core.dataset import Dataset

from prepare_data import PREPARED_DIR as PD
from src.analysis import plot_log_km_comparison, plot_nadh_comparison, plot_vars

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
    n_level = len(df.columns.levels)
    if n_level < 2:
        raise ValueError("Not enough levels to flatten!")
    new = df.copy()
    new_columns = df.columns.get_level_values(0)
    new_columns_name = df.columns.names[0]
    for i in range(n_level - 1):
        iplusone_vals = df.columns.get_level_values(i + 1)
        iplusone_name = df.columns.names[i + 1]
        new_columns = [
            f"{v_i}{sep}{v_iplusone}"
            for v_i, v_iplusone in zip(new_columns, iplusone_vals)
        ]
        new_columns_name = f"{new_columns_name}{sep}{iplusone_name}"
    new.columns = new_columns
    new.rename_axis(new_columns_name, axis="columns")
    return new


def main():
    # load data
    posteriors = {
        os.path.basename(d): az.from_netcdf(os.path.join(d, "posterior.nc"))
        for d in RUN_DIRS
    }
    input_dfs = {
        "sabio-km": pd.read_csv(os.path.join(PD, "sabio_km", "lits.csv")),
        "brenda-km": pd.read_csv(os.path.join(PD, "brenda_km", "lits.csv")),
    }
    posterior_km = posteriors["sabio-km-enz"].get("posterior")
    posterior_km_brenda = posteriors["brenda-km-blk"].get("posterior")

    # Ensure that posterior_km has the right type (mainly to shut up the checker...)
    assert isinstance(posterior_km, Dataset)
    assert isinstance(posterior_km_brenda, Dataset)

    # compare the sd parameters
    f = plot_vars(posterior_km, vars=["tau", "sigma"])
    f.savefig(os.path.join("results", "plots", "sd_posteriors.png"))

    # nadh comparison
    f = plot_nadh_comparison(posterior_km, input_dfs["sabio-km"])
    f.savefig(os.path.join("results", "plots", "nadh.png"))

    # log km comparison
    f = plot_log_km_comparison(posterior_km, posterior_km_brenda)
    f.savefig(os.path.join("results", "plots", "log_km_comparison.png"))


if __name__ == "__main__":
    main()
