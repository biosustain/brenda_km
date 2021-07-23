This folder contains configuration information for the models that we want to
compare. Specifically:

- `name` An arbitrary name for the model configuration
- `stan_file` The stan file representing the statistical model
- `data_file` Path to the prepared data csv, starting at the project root.
- `likelihood` Whether or not to take into account measurements
- `sample_kwargs` A table of keyword arguments for `cmdstanpy.CmdStanModel.sample`

Here is an example model configuration file:

```toml
name = "toy_fixed"
stan_file = "src/stan/model.stan"
data_file = "data/prepared/prepared_data.csv"
likelihood = true
run = false

[sample_kwargs]
chains = 1
iter_sampling = 2
show_progress = true
inits = 0
fixed_param = true
```
