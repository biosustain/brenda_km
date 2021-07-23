"""Definition of the ModelConfiguration class."""

from typing import List
from dataclasses import dataclass
import os


@dataclass
class ModelConfiguration:
    """Container for a path to a Stan model and some configuration.

    For example, you may want to compare how well two stan programs fit the
    same data, or how well the same model fits the data with different
    covariates.

    :param name: string name identifying the model configuration

    :param stan_file: Path to a Stan program, with "/" even on windows

    :param data_file: Path to a data file, with "/" even on windows

    :param priors_file: Path to a file of priors, with "/" even on windows

    :param sample_kwargs: dictionary of keyword arguments to
    cmdstanpy.CmdStanModel.sample.

    :param likelihood: whether or not to take measurements into account

    :param do_not_run: whether or not to run this model configuration

    """

    name: str
    stan_file: str
    data_file: str
    priors_file: str
    sample_kwargs: dict
    likelihood: bool
    do_not_run: bool = False

    def __post_init__(self) -> None:
        """Handle windows paths correctly"""
        self.stan_file = os.path.join(*self.stan_file.split("/"))
        self.data_file = os.path.join(*self.data_file.split("/"))
        self.priors_file = os.path.join(*self.priors_file.split("/"))
