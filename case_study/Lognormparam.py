import numpy as np
from typing import Tuple
from scipy.stats import norm

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