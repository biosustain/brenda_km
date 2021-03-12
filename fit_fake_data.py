"""A script for running a fake data simulation study.

NB this must be run after prepare_data.py as it uses real data to ensure a
realistic distribution of ec values and temperatures.

"""

from datetime import datetime
import os
import numpy as np
import pandas as pd

from model_configurations_to_try import MODEL_CONFIGURATIONS
from model_configurations_to_try import (
    TEMPERATURE_CONFIG_PRIOR as TRUE_MODEL_CONFIG,
)
from fake_data_generation import generate_fake_measurements
from fitting import generate_samples

# True values for each variable in your program's `parameters` block. Make sure
# that the dimensions agree with `TRUE_MODEL_FILE`!
TRUE_PARAM_VALUES = {
    "mu": 0.1,
    "nu": 5,
    "sigma": 1.5,
    "b": [0.1, 0.2],
    "tau": [0.2, 0.1, 0.1],
}

# How many fake measurements should be generated?
N_FAKE_MEASUREMENTS = 100

# Where to find real data
REAL_DATA_CSV = os.path.join("data", "prepared", "data_prepared.csv")

# Where to save fake data
FAKE_DATA_DIR = os.path.join("data", "fake")


def main():
    """Run a simulation study."""
    now = datetime.now().strftime("%Y%m%d%H%M%S")
    study_name = f"sim_study-{now}"
    print("Generating fake data...")
    real_data = pd.DataFrame(pd.read_csv(REAL_DATA_CSV))
    true_param_values = TRUE_PARAM_VALUES.copy()
    for i, ec_type in enumerate(["ec4", "ec3", "ec2"]):
        true_param_values[ec_type] = np.random.normal(
            0, TRUE_PARAM_VALUES["tau"][i], real_data[ec_type].nunique()
        )
    measurements = generate_fake_measurements(
        true_param_values, TRUE_MODEL_CONFIG, real_data
    )
    fake_data_file = os.path.join(FAKE_DATA_DIR, f"fake_data-{study_name}.csv")
    print(f"Writing fake data to {fake_data_file}")
    measurements.to_csv(fake_data_file)
    generate_samples(study_name, measurements, MODEL_CONFIGURATIONS)


if __name__ == "__main__":
    main()
