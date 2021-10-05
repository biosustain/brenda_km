import os

from src.fitting import sample
from src.loading import load_model_configuration

MODEL_CONFIGURATION_DIR = "model_configurations"


def main():
    config_files = [
        os.path.join(MODEL_CONFIGURATION_DIR, f)
        for f in os.listdir(MODEL_CONFIGURATION_DIR)
        if f.endswith(".toml")
    ]
    for config_file in sorted(config_files):
        mc = load_model_configuration(config_file)
        if not mc.do_not_run:
            mcmc, idata = sample(mc)


if __name__ == "__main__":
    main()
