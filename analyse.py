"""Script for drawing graphs after running sample.py"""

import os

import arviz as az
import pandas as pd
from xarray.core.dataset import Dataset

from prepare_data import PREPARED_DIR
from src.analysis import (
    plot_concentration_comparison,
    plot_log_km_comparison,
    plot_nadh_comparison,
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


def main():
    # load data
    posteriors = {
        os.path.basename(d): az.from_netcdf(os.path.join(d, "posterior.nc"))
        for d in RUN_DIRS
    }
    dfs = {
        "sabio": load_df(os.path.join(PREPARED_DIR, "sabio_km", "lits.csv")),
        "brenda": load_df(os.path.join(PREPARED_DIR, "brenda_km", "lits.csv")),
        "sabio_concs": load_df(os.path.join(PREPARED_DIR, "sabio_concs.csv")),
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
    f = plot_nadh_comparison(posterior_km, dfs["sabio"])
    f.savefig(os.path.join("results", "plots", "nadh.png"))

    # log km comparison
    f = plot_log_km_comparison(posterior_km, posterior_km_brenda)
    f.savefig(os.path.join("results", "plots", "log_km_comparison.png"))

    # concentration comparison
    f = plot_concentration_comparison(posterior_km, dfs["sabio_concs"])
    f.savefig(os.path.join("results", "plots", "concentration_comparison.png"))


if __name__ == "__main__":
    main()
