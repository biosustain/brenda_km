"""Generate a fake set of measurements using a model."""

import json
import os

import numpy as np
from cmdstanpy import CmdStanModel, write_stan_json

HARD_CODED_PARAMS = {
    "nu": 4,
    "mu": -2,
    "sigma": 0.8,
    "tau_sub": 1.6,
    "tau_ec_sub": 0.6,
    "tau_org_sub": 1.1,
}
SAMPLE_KWARGS = {
    "chains": 1,
    "iter_warmup": 0,
    "iter_sampling": 1,
    "fixed_param": True,
}

DATA_DIR_TO_COPY = os.path.join("data", "prepared", "tenfold")
INPUT_FILE_ORIG = os.path.join(DATA_DIR_TO_COPY, "stan_input_posterior.json")
TRUE_MODEL_FILE = os.path.join("src", "stan", "blk.stan")
OUTPUT_FILES = {
    "stan_input": os.path.join(DATA_DIR_TO_COPY, "stan_input_fake.json"),
    "params": os.path.join(DATA_DIR_TO_COPY, "fake_data_params.json"),
}


def main():
    with open(INPUT_FILE_ORIG, "r") as f:
        input_orig = json.load(f)
    rng_params = {
        f"a_{suff}": np.random.normal(
            0, HARD_CODED_PARAMS[f"tau_{suff}"], input_orig[f"N_{suff}"]
        ).tolist()
        for suff in ["sub", "ec_sub", "org_sub"]
    }
    params = {**HARD_CODED_PARAMS, **rng_params}
    model = CmdStanModel(stan_file=TRUE_MODEL_FILE)
    mcmc = model.sample(data=input_orig, inits=params, **SAMPLE_KWARGS)
    generated_y = mcmc.stan_variable("yrep").reshape(-1)
    for param in rng_params.keys():
        print(f"min {param}:", min(params[param]))
        print(f"max {param}:", max(params[param]))
    print(generated_y)
    print(generated_y.min())
    print(generated_y.max())
    input_fake = input_orig.copy()
    input_fake["y_train"] = generated_y
    input_fake["y_test"] = generated_y
    write_stan_json(OUTPUT_FILES["stan_input"], input_fake)
    write_stan_json(OUTPUT_FILES["params"], params)


if __name__ == "__main__":
    main()
