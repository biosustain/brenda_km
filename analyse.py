import os

import arviz as az
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from matplotlib import ticker
from xarray.core.dataset import Dataset

from prepare_data import PREPARED_DIR as PD

RUN_DIR_PARENT = os.path.join("results", "runs")
IDATA_RELPATH = os.path.join("posterior", "idata.nc")
RUN_DIRS = list(
    filter(
        os.path.isdir,
        [os.path.join(RUN_DIR_PARENT, d) for d in os.listdir(RUN_DIR_PARENT)],
    )
)
HMDB_PATH = os.path.join(PD, "hmdb_concs.csv")


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
    idatas = {
        os.path.basename(d): az.from_netcdf(os.path.join(d, IDATA_RELPATH))
        for d in RUN_DIRS
    }
    hmdb = pd.read_csv(HMDB_PATH)
    input_dfs = {
        "sabio-km": pd.read_csv(os.path.join(PD, "sabio_km", "lits.csv")),
        "brenda-km": pd.read_csv(os.path.join(PD, "brenda_km", "lits.csv")),
    }

    # Check out of sample predictions
    loo = {k: az.loo(v, pointwise=True) for k, v in idatas.items()}
    print(loo)
    comparison = az.compare(idatas)
    print(comparison)
    posterior_km = idatas["sabio-km-enz"].get("posterior")

    # Ensure that posterior_km has the right type (mainly to shut up the checker...)
    assert isinstance(posterior_km, Dataset)

    # compare the sd parameters
    az.plot_forest(
        posterior_km,
        filter_vars="regex",
        var_names="tau|sigma",
        combined=True,
        kind="ridgeplot",
        hdi_prob=0.999,
    )
    plt.gcf().savefig(os.path.join("results", "plots", "sd_posteriors.png"))

    # maps from biologies to other interesting
    biology_maps = {
        k: pd.DataFrame(
            {
                c: input_dfs[k].groupby("biology_stan")[c].first()
                if c in input_dfs[k].columns
                else None
                for c in [
                    "substrate",
                    "ec4",
                    "uniprot_id",
                    "organism",
                    "biology",
                ]
            }
        ).set_index("biology")
        for k in input_dfs.keys()
    }
    biology_y_means = {
        k: input_dfs[k].groupby("biology")["y"].mean().rename("y_mean")
        for k in input_dfs.keys()
    }

    log_km_qs = (
        posterior_km["log_km"]
        .quantile([0.01, 0.99], dim=["chain", "draw"])
        .to_series()
        .unstack("quantile")
        .join(biology_maps["sabio-km"])
        .join(biology_y_means["sabio-km"])
    )

    # plot qs
    t = log_km_qs.sort_values("y_mean")
    f, ax = plt.subplots(figsize=[12, 8])
    xlow, xhigh = ax.get_xlim()
    x = np.linspace(xlow, xhigh, len(t))
    ax.vlines(x, t[0.01], t[0.99], color="tab:blue", zorder=0)
    ax.scatter(x, t["y_mean"], color="black")
    f.savefig(os.path.join("results", "plots", "ppc_km_sabio_enz.png"))

    # do the hmdb concentrations generally agree with the model and measurements?
    t = (
        log_km_qs.query("organism == 'Homo sapiens'")
        .join(
            hmdb.groupby("metabolite")["concentration_uM"].mean(),
            on="substrate",
        )
        .dropna(subset=["concentration_uM"])
        .assign(concentration_M=lambda df: df["concentration_uM"] * 1e-6)
    )
    unlog_formatter = ticker.FuncFormatter(
        lambda t, _: str(round(1e6 * np.exp(t), 4))
    )
    x = t["concentration_M"].pipe(np.log)
    f, ax = plt.subplots(figsize=[15, 10])
    ax.vlines(x=x, ymin=t[0.01], ymax=t[0.99], zorder=0, label="1%-99% CI")
    ax.scatter(
        x, t["y_mean"], color="black", label="average SABIO-rk measurement"
    )
    ax.plot(x, x, color="red", label="y=x")
    ax.xaxis.set_major_formatter(unlog_formatter)
    ax.yaxis.set_major_formatter(unlog_formatter)
    ax.legend(frameon=False)
    ax.set(
        xlabel="Physiological concentration from HMDB ($\mu$M, ln scale)",
        ylabel="kM value ($\mu$M, ln scale)",
    )
    f.suptitle(
        "Do modelled and measured kMs match physiological concentrations?",
        fontsize=24,
    )
    plt.title(
        "Comparison of physiological human metabolite concentrations from HMDB\n"
        "and kM values for the same metabolites from SABIO-RK measurements and "
        "our model"
    )
    f.patch.set_alpha(1)
    f.savefig(os.path.join("results", "plots", "hmdb_comparison.png"))

    # Is there a systematic relationship between NADH and NADPH kMs?
    nadh_nadph_comparison = (
        log_km_qs.set_index(["organism", "uniprot_id", "substrate"])[
            [0.01, 0.99, "y_mean"]
        ]
        .rename_axis("quantile", axis=1)
        .stack()
        .reset_index()
        .query("substrate in ('NADH', 'NADPH')")
        .set_index(["organism", "uniprot_id", "quantile", "substrate"])[0]
        .unstack(["substrate", "quantile"])
        .dropna(how="any")
        .pipe(flatten_columns, sep="_")
        .sort_values("NADH_y_mean")
    )
    f, ax = plt.subplots(figsize=[12, 8])
    x = nadh_nadph_comparison["NADH_y_mean"]
    y = nadh_nadph_comparison["NADPH_y_mean"]
    ax.scatter(x, y, label="Average measurement")
    ax.legend(frameon=False)
    ax.set_xlabel("Average NADH kM measurement ($\mu$M, $\ln$ scale)")
    ax.set_ylabel("Average NADPH kM measurement ($\mu$M, $\ln$ scale")
    my_formatter = ticker.FuncFormatter(
        lambda t, _: str(round(1e6 * np.exp(t), 4))
    )
    for a in (ax.xaxis, ax.yaxis):
        a.set_major_formatter(my_formatter)
    f.suptitle(
        "Is there a systematic relationship between NADH and NADPH kMs?",
        fontsize=24,
    )
    plt.title(
        "Comparison of average measured kM from SABIO-RK for enzymes with"
        " data for both NADH and NADPH"
    )
    f.patch.set_alpha(1)
    f.savefig(os.path.join("results", "plots", "nadh_comparison.png"))

    # any interesting parameter values?
    def stringify_columns(df):
        new = df.copy()
        new_columns = map(str, df.columns)
        new.columns = new_columns
        return new

    a_sub = (
        posterior_km["a_substrate"]
        .quantile([0.01, 0.5, 0.99], dim=["chain", "draw"])
        .to_series()
        .unstack("quantile")
        .pipe(stringify_columns)
        .sort_values("0.5")
        .join(input_dfs["sabio-km"].groupby("substrate").size().rename("N"))
    )
    a_org_sub = (
        posterior_km["a_org_sub"]
        .quantile([0.01, 0.5, 0.99], dim=["chain", "draw"])
        .to_series()
        .unstack("quantile")
        .pipe(stringify_columns)
        .sort_values("0.5")
        .join(input_dfs["sabio-km"].groupby("org_sub").size().rename("N"))
        .assign(
            organism=lambda df: [
                i.split("|")[0] for i in df.index.get_level_values(0)
            ],
            substrate=lambda df: [
                None if i.startswith("unknown") else i.split("|")[1]
                for i in df.index.get_level_values(0)
            ],
        )
    )
    a_ec4_sub = (
        posterior_km["a_ec4_sub"]
        .quantile([0.01, 0.5, 0.99], dim=["chain", "draw"])
        .to_series()
        .unstack("quantile")
        .pipe(stringify_columns)
        .sort_values("0.5")
        .join(input_dfs["sabio-km"].groupby("ec4_sub").size().rename("N"))
        .assign(
            ec4=lambda df: [
                i.split("|")[0] for i in df.index.get_level_values(0)
            ],
            substrate=lambda df: [
                None if i.startswith("unknown") else i.split("|")[1]
                for i in df.index.get_level_values(0)
            ],
        )
    )
    a_enz_sub = (
        posterior_km["a_enz_sub"]
        .quantile([0.01, 0.5, 0.99], dim=["chain", "draw"])
        .to_series()
        .unstack("quantile")
        .pipe(stringify_columns)
        .sort_values("0.5")
        .join(input_dfs["sabio-km"].groupby("enz_sub").size().rename("N"))
        .assign(
            uniprot_id=lambda df: [
                i.split("|")[0] for i in df.index.get_level_values(0)
            ],
            substrate=lambda df: [
                None if i.startswith("unknown") else i.split("|")[1]
                for i in df.index.get_level_values(0)
            ],
        )
    )


if __name__ == "__main__":
    main()
