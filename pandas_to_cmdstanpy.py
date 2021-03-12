"""Get an input to cmdstanpy.CmdStanModel.sample from a pd.DataFrame."""

from typing import List, Dict
import pandas as pd
from util import one_encode


def get_stan_input(
    measurements: pd.DataFrame,
    x_cols: List[str],
    priors: Dict,
    likelihood: bool,
) -> Dict:
    """Get an input to cmdstanpy.CmdStanModel.sample.

    :param measurements: a pandas DataFrame whose rows represent measurements

    :param model_config: a dictionary with keys "priors", "likelihood" and
    "x_cols".

    """
    return {
        **priors,
        **{
            "N": len(measurements),
            "K": len(x_cols),
            "N_ec4": measurements["ec4"].nunique(),
            "N_ec3": measurements["ec3"].nunique(),
            "N_ec2": measurements["ec2"].nunique(),
            "ec4": one_encode(measurements["ec4"]).values,
            "ec3": one_encode(measurements["ec3"]).values,
            "ec2": one_encode(measurements["ec2"]).values,
            "x": measurements[x_cols].values,
            "y": measurements["log_km"].values,
            "N_test": len(measurements),
            "x_test": measurements[x_cols].values,
            "y_test": measurements["log_km"].values,
            "likelihood": int(likelihood),
        },
    }
