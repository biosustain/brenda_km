"""Take the table at INPUT_FILE and add columns 'mu' and 'sigma' based on our results"""

import os
from typing import Tuple

import arviz as az
import numpy as np
import pandas as pd
from scipy.stats import norm
from tqdm import tqdm

BRENDA_RESULTS_PATH = os.path.join(
    "..", "results", "runs", "brenda-blk", "posterior.nc"
)
INPUT_FILE = "modelquery.csv"
OUTPUT_FILE = "Pred_Priors.csv"
ORGANISM = "Trypanosoma brucei"


def get_lognormal_params_from_qs(
    x1: float, x2: float, p1: float, p2: float
) -> Tuple[float, float]:
    """Find parameters for a lognormal distribution from two quantiles.

    i.e. get mu and sigma such that if X ~ lognormal(mu, sigma), then pr(X <
    x1) = p1 and pr(X < x2) = p2.

    :param x1: the lower value
    :param x2: the higher value
    :param p1: the lower quantile
    :param p1: the higher quantile

    """
    logx1 = np.log(x1)
    logx2 = np.log(x2)
    denom = norm.ppf(p2) - norm.ppf(p1)
    sigma = (logx2 - logx1) / denom
    mu = (logx1 * norm.ppf(p2) - logx2 * norm.ppf(p1)) / denom
    return mu, sigma


def main():
    modelquery = pd.read_csv(INPUT_FILE, delimiter=";")
    assert isinstance(modelquery, pd.DataFrame)
    idata = az.from_netcdf(BRENDA_RESULTS_PATH)
    modelled_ec4_subs = idata.posterior.coords["ec4_sub"].values
    modelled_org_subs = idata.posterior.coords["org_sub"].values
    modelled_subs = idata.posterior.coords["substrate"].values
    mus = []
    sigmas = []
    pbar = tqdm(modelquery.iterrows(), total=len(modelquery))
    for _, row in pbar:
        sub_in = row["Substrate"]
        ec4_in = row["ECnumber"]
        ec4_sub_in = f"{ec4_in}|{sub_in}"
        org_sub_in = f"{ORGANISM}|{sub_in}"
        sub = sub_in if sub_in in modelled_subs else "unknown"
        ec4_sub = ec4_sub_in if ec4_sub_in in modelled_ec4_subs else "unknown"
        org_sub = org_sub_in if org_sub_in in modelled_org_subs else "unknown"
        log_km_samples = (
            idata.posterior["mu"]
            + idata.posterior["a_substrate"].sel({"substrate": sub})
            + idata.posterior["a_ec4_sub"].sel({"ec4_sub": ec4_sub})
            + idata.posterior["a_org_sub"].sel({"org_sub": org_sub})
        )
        q_1pct, q_99pct = np.exp(
            log_km_samples.quantile([0.01, 0.99], dim=["chain", "draw"]).values
        )
        mu, sigma = get_lognormal_params_from_qs(q_1pct, q_99pct, 0.01, 0.99)
        mus.append(mu)
        sigmas.append(sigma)
    out = modelquery.copy()
    out["mu"] = mus
    out["sigma"] = sigmas
    out.to_csv(OUTPUT_FILE)


if __name__ == "__main__":
    main()
