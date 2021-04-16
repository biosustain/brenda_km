"""Get an input to cmdstanpy.CmdStanModel.sample from a pd.DataFrame."""

from typing import Dict
import pandas as pd
from .util import one_encode


def get_stan_input(
    measurements: pd.DataFrame,
    priors: Dict,
    likelihood: bool,
) -> Dict:
    """Get an input to cmdstanpy.CmdStanModel.sample.

    :param measurements: a pandas DataFrame whose rows represent measurements

    :param model_config: a dictionary with keys "priors", "likelihood" and
    "x_cols".

    """
    ec3_to_ec4 = (
        one_encode(measurements["ec3"])
        .groupby(one_encode(measurements["ec4"]))
        .first()
    )
    return {
        **priors,
        **{
            "N": measurements.shape[0],
            "N_ec4": measurements["ec4"].nunique(),
            "N_ec3": measurements["ec3"].nunique(),
            "N_ec2": measurements["ec2"].nunique(),
            "N_subs": measurements["substrate"].nunique(),
            "N_superking": measurements["superkingdom"].nunique(),
            "N_family": measurements["family"].nunique(),
            "N_genus": measurements["genus"].nunique(),
            "N_species": measurements["species"].nunique(),
            "ec4": one_encode(measurements["ec4"]).values,
            "ec3": one_encode(measurements["ec3"]).values,
            "ec2": one_encode(measurements["ec2"]).values,
            "ec3_to_ec4": ec3_to_ec4.values,
            "subs": one_encode(measurements["substrate"]).values,
            "superking": one_encode(measurements["superkingdom"]).values,
            "family": one_encode(measurements["family"]).values,
            "genus": one_encode(measurements["genus"]).values,
            "species": one_encode(measurements["species"]).values,
            "y": measurements["log_km"].values,
            "N_test": len(measurements),
            "y_test": measurements["log_km"].values,
            "likelihood": int(likelihood),
        },
    }
