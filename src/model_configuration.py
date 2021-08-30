"""Definition of the ModelConfiguration class."""

import os
from dataclasses import dataclass
from typing import List


@dataclass
class ModelConfiguration:
    """Container for a path to a Stan model and some configuration.

    For example, you may want to compare how well two stan programs fit the
    same data, or how well the same model fits the data with different
    covariates.

    :param name: string name identifying the model configuration

    :param stan_file: Path to a Stan program, with "/" even on windows

    :param data_file: Path to a data file, with "/" even on windows

    :param coords_file: Path to a file of coords, with "/" even on windows

    :param dims_file: Path to a file of dims, with "/" even on windows

    :param sample_kwargs: dictionary of keyword arguments to
    cmdstanpy.CmdStanModel.sample.

    :param do_not_run: whether or not to run this model configuration

    """

    name: str
    stan_file: str
    data_file: str
    coords_file: str
    dims_file: str
    sample_kwargs: dict
    do_not_run: bool = False

    def __post_init__(self) -> None:
        """Handle windows paths correctly"""
        self.stan_file = os.path.join(*self.stan_file.split("/"))
        self.data_file = os.path.join(*self.data_file.split("/"))
        self.coords_file = os.path.join(*self.coords_file.split("/"))
        self.dims_file = os.path.join(*self.dims_file.split("/"))
