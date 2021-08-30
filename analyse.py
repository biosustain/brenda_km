import os
import warnings

import arviz as az
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt

idata_cat, idata_simple = (
    az.from_netcdf(os.path.join("results", "idata", f))
    for f in (
        "idata_cat_model_likelihood_natural_only.nc",
        "idata_simple_model_likelihood.nc",
    )
)

with warnings.catch_warnings():
    warnings.simplefilter("ignore")
    loo_cat = az.loo(idata_cat, pointwise=True)
    loo_simple = az.loo(idata_simple, pointwise=True)
    comparison = az.compare({"cat": idata_cat, "simple": idata_simple})

khat = {"cat": loo_cat.pareto_k, "simple": loo_simple.pareto_k}
min_khat = min(khat["cat"].min(), khat["simple"].min())
max_khat = max(khat["cat"].max(), khat["simple"].max())
bins = np.linspace(min_khat - 0.1, max_khat + 0.1, 40)
f, ax = plt.subplots()
for model, khats in khat.items():
    hist = ax.hist(khats, bins=bins, label=model, alpha=0.7)
xlabel = ax.set_xlabel("khat value")
ylabel = ax.set_ylabel("Number of observations")
leg = ax.legend(frameon=False)

q_cat, q_simple = (
    idata.posterior["log_km"]
    .quantile([0.01, 0.5, 0.99], dim=["chain", "draw"])
    .to_series()
    .unstack("quantile")
    .add_prefix(pref + "_")
    for idata, pref in ((idata_cat, "cat"), (idata_simple, "simple"))
)
q = (
    q_cat.join(q_simple)
    .assign(y=idata_cat.observed_data["y"].values)
    .sort_values("y")
)

f, ax = plt.subplots()

x = np.linspace(*ax.get_xlim(), len(q))

for pref, color in (("cat_", "tab:blue"), ("simple_", "tab:orange")):
    ax.vlines(
        x,
        q[pref + "0.01"],
        q[pref + "0.99"],
        color=color,
        label=pref[:-1],
        alpha=0.7,
    )
ax.scatter(x, q["y"], color="black", zorder=3, label="average measurement")
ax.set_ylabel("log km")
ax.set_xticks([])
ax.legend(frameon=False)
