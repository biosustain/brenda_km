"""Script that draws some plots investigating weird results.

Specifically, these are cases where the posterior draws seem to disagree with
the direct observations.

"""
import os

import arviz as az
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from matplotlib.patches import Patch

from src.util import increment_df_index

OUTPUT_DIR = os.path.join("results", "plots", "weird_results")
WEIRD_RESULTS = [
    ("Trypanosoma brucei", "2.7.4.3", "ATP"),
    ("Trypanosoma brucei", "4.2.1.11", "phosphoenolpyruvate"),
    ("Trypanosoma brucei", "1.1.1.8", "sn-glycerol 3-phosphate"),
    ("Trypanosoma brucei", "1.1.1.8", "NAD+"),
    ("Trypanosoma brucei", "1.2.1.12", "3-phospho-D-glyceroyl phosphate"),
    ("Trypanosoma brucei", "2.7.1.30", "sn-glycerol 3-phosphate"),
    ("Trypanosoma brucei", "2.7.1.30", "ATP"),
    # this is so weird because the prior defined in the literature matches the
    # mode of our prior but not the Brenda results
    ("Trypanosoma brucei", "2.7.1.11", "ATP"),
    ("Trypanosoma brucei", "5.3.1.9", "D-fructose 6-phosphate"),
    ("Trypanosoma brucei", "2.7.2.3", "3-phospho-D-glycerate"),
    ("Trypanosoma brucei", "2.7.1.40", "phosphoenolpyruvate"),
    # this had about 40 entries in Brenda, I included some representative
    # from all the range they covered
    ("Trypanosoma brucei", "5.3.1.1", "D-Glyceraldehyde 3-phosphate"),
]


def main():
    """Run the script."""
    if not os.path.exists(OUTPUT_DIR):
        os.mkdir(OUTPUT_DIR)
    # load data
    idata = az.from_netcdf(
        os.path.join("results", "runs", "brenda-blk", "posterior.nc")
    )
    biologies = (
        idata.posterior.coords["biology"]
        .to_dataframe()
        .reset_index(drop=True)
        .pipe(increment_df_index)
    )
    p = idata.posterior
    obs = pd.DataFrame(
        {
            "biology_ix": idata.observed_data["biology_train"],
            "y": idata.observed_data["y"].values,
        }
    ).join(biologies, on="biology_ix")

    # draw plots
    for organism, ec4, sub in WEIRD_RESULTS:
        biology = "|".join([organism, ec4, sub])
        if biology not in biologies["biology"].values:
            print(f"No direct observations for biology {biology}.")
            continue
        log_km_draws = p["log_km"].sel(biology=biology)
        mu_draws = p["mu"]
        a_substrate_draws = p["a_substrate"].sel(substrate=sub)
        a_ec4_sub_draws = p["a_ec4_sub"].sel(ec4_sub=f"{ec4}|{sub}")
        a_org_sub_draws = p["a_org_sub"].sel(org_sub=f"{organism}|{sub}")
        directly_observed = obs.loc[lambda df: df["biology"] == biology, "y"]
        observed_same_substrate = obs.loc[
            lambda df: df["biology_substrate"] == sub, "y"
        ]
        observed_same_org_sub = obs.loc[
            lambda df: (df["biology_organism"] == organism)
            & (df["biology_substrate"] == sub),
            "y",
        ]
        observed_same_ec4_sub = obs.loc[
            lambda df: (df["biology_ec4"] == ec4)
            & (df["biology_substrate"] == sub),
            "y",
        ]
        f, axes = plt.subplots(1, 4, figsize=[15, 5], sharex=True, sharey=True)
        bins = np.linspace(-10, 5, 50)
        for ax, draws, obs_y in zip(
            axes,
            [log_km_draws, a_substrate_draws, a_ec4_sub_draws, a_org_sub_draws],
            [
                directly_observed,
                observed_same_substrate,
                observed_same_ec4_sub,
                observed_same_org_sub,
            ],
        ):
            draws_plot = draws + mu_draws if draws.name != "log_km" else draws
            ax.hist(
                draws_plot.values.ravel(),
                alpha=0.8,
                label="posterior draws",
                bins=bins,
                density=True,
            )
            ax.hist(
                obs_y.values,
                color="red",
                label="matchingobservations",
                alpha=0.5,
                bins=bins,
                density=True,
            )
            title = (
                draws.name.replace("a_", "") + " effect"
                if draws.name != "log_km"
                else draws.name
            )
            ax.set_title(title)
        axes[0].set_ylabel("density")
        f.legend(
            [Patch(color="tab:blue"), Patch(color="red")],
            ["posterior_draws", "matching observations"],
            frameon=False,
            loc="lower center",
            ncol=2,
        )
        f.suptitle(biology)
        f.savefig(os.path.join(OUTPUT_DIR, f"{biology}.png"))


if __name__ == "__main__":
    main()
