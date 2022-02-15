import json
import os
from typing import Dict, List

import arviz as az
import numpy as np
import pandas as pd
from cmdstanpy import CmdStanModel

from case_study.hardcoding import ORGANISM, P_NAMES, REACTION_TO_EC4
from src.data_preparation import check_is_df

TIMEPOINTS = list(np.linspace(0, 2, 100))[1:]
REL_TOL = 1e-12
ABS_TOL = 1e-12
MAX_NUM_STEPS = int(1e9)
COORDS_FILE = "coords.json"
KERKHOVENB_FILE = "config_kerkhovenB.json"
POSTERIOR_SUMMARY_PATH = os.path.join(
    "results", "runs", "brenda-km-blk", "posterior_summary.csv"
)
DIMS = {"x": ["time", "species"], "x_c": ["time", "species"]}


def get_posterior_summaries(
    all_summaries: pd.DataFrame,
    p_names: List[str],
    reaction_to_ec4: Dict[str, str],
) -> Dict[str, Dict[str, pd.DataFrame]]:
    relevant_pnames = [
        p
        for p in p_names
        if "Km" in p and p.split("_")[-3] in reaction_to_ec4.keys()
    ]
    reaction_to_substrates = {r: set() for r in reaction_to_ec4.keys()}
    for p in filter(lambda p: "Km" in p, p_names):
        reaction = p.split("_")[-3]
        if "Km" in p and reaction in reaction_to_ec4.keys():
            substrate = p.split("Km")[-1]
            reaction_to_substrates[reaction] |= {substrate}
    for reaction, substrates in reaction_to_substrates.items():
        ec4 = reaction_to_ec4[reaction]
        for substrate in list(substrates):
            print(f"*** {reaction} {substrate} {ec4} ***")
            print(all_summaries.loc[lambda df: (df["biology_ec4"] == ec4) & (df["biology_substrate"] == substrate)])



def main():
    # loading
    with open(COORDS_FILE, "r") as f:
        coords = json.load(f)
        coords["time"] = list(map(str, [0.0] + TIMEPOINTS))
    with open(KERKHOVENB_FILE, "r") as f:
        kerkhoven = json.load(f)
    posterior_summary = check_is_df(
        pd.read_csv(POSTERIOR_SUMMARY_PATH, index_col=0)
    )
    .loc[lambda df: df["biology_organism"].str.contains("brucei")]
    posterior_substrates = posterior_summary["biology_substrate"].unique()
    kms = [
        p
        for p in P_NAMES
        if "Km" in p and p.split("Km")[-1] in posterior_substrates
    ]
    data = {
        **kerkhoven,
        **{
            "N": len(TIMEPOINTS),
            "timepoints": TIMEPOINTS,
            "rel_tol": REL_TOL,
            "abs_tol": ABS_TOL,
            "max_num_steps": MAX_NUM_STEPS,
        },
    }
    m = CmdStanModel(stan_file="case_study.stan")
    mcmc = m.sample(
        data=data,
        fixed_param=True,
        iter_sampling=1,
        iter_warmup=0,
        show_console=True,
    )
    idata = az.from_cmdstanpy(mcmc, dims=DIMS, coords=coords)
    idata.to_netcdf("idata.nc")
    xc = idata.posterior["x_c"].to_series().loc[(0, 0)].unstack()
    print(xc.iloc[-1].sort_values())


if __name__ == "__main__":
    main()
