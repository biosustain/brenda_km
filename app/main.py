import os

import arviz as az
import numpy as np
import pandas as pd
from bokeh.io import curdoc
from bokeh.layouts import column, row
from bokeh.models import Button, Select
from bokeh.models.sources import ColumnDataSource
from bokeh.plotting import figure
from scipy.stats.kde import gaussian_kde


def get_predictor_classes(measurements: pd.DataFrame) -> pd.DataFrame:
    """Reimplementing function from sibling"""
    out = (
        measurements.groupby(["organism", "ec3", "ec4", "is_natural"])
        .size()
        .rename("n_measurements")
        .sort_values(ascending=False)
        .reset_index()
    )
    out.index += 1
    return out


# Hardcoded info
NCDF_FILE = os.path.join(
    "results", "infd", "infd_real_study-20210506170800-natural_model.ncdf"
)
MEASUREMENTS_FILE = os.path.join("data", "prepared", "data_prepared.csv")

# data that doesn't get changed
msmts = pd.read_csv(MEASUREMENTS_FILE)
infd = az.from_netcdf(NCDF_FILE)
pc = get_predictor_classes(msmts)
nat = msmts.groupby(["organism", "ec4", "substrate"])["is_natural"].first()
options_o = msmts["organism"].unique().tolist()
options_e = msmts.groupby("organism")["ec4"].unique()
options_s = msmts.groupby(["organism", "ec4"])["substrate"].unique()

# variables below here are mutable
source = ColumnDataSource()
source_obs = ColumnDataSource()
fig = figure(name="fig")

# widgets
select_o = Select(title="Organism", value=options_o[0], options=options_o)
select_e = Select(
    title="EC number",
    value=options_e.loc[select_o.value][0],
    options=options_e.loc[select_o.value].tolist(),
)
select_s = Select(
    title="Substrate",
    value=options_s.loc[(select_o.value, select_e.value)][0],
    options=options_s.loc[(select_o.value, select_e.value)].tolist(),
)
button = Button(label="redraw!")


# Callbacks and when to use them
def select_o_change(attrname, old, new):
    select_e.value = options_e.loc[new][0]
    select_e.options = options_e.loc[new].tolist()


def select_e_change(attrname, old, new):
    select_s.value = options_s.loc[(select_o.value, new)][0]
    select_s.options = options_s.loc[(select_o.value, new)].tolist()


def update():
    is_natural = nat.loc[(select_o.value, select_e.value, select_s.value)]
    pc_ix = pc.loc[
        lambda df: (df["ec4"] == select_e.value)
        & (df["organism"] == select_o.value)
        & (df["is_natural"] == is_natural)
    ].index
    obs = msmts.loc[
        lambda df: (df["ec4"] == select_e.value)
        & (df["organism"] == select_o.value)
        & (df["is_natural"] == is_natural),
        "log_km",
    ].values
    samples = infd.posterior["yhat"].sel({"predictor_class": pc_ix}).to_series().values
    kde = gaussian_kde(samples)
    x = np.linspace(samples.min() - 0.5, samples.max() + 0.5, 100)
    y = kde(x)
    source.data = {"x": x, "y": y}
    source_obs.data = {"obs": obs, "obsy": np.zeros(len(obs))}


select_o.on_change("value", select_o_change)
select_e.on_change("value", select_e_change)
button.on_click(update)

# commands
update()
fig.patch("x", "y", source=source, alpha=0.6)
fig.scatter("obs", "obsy", size=4, source=source_obs)
inputs_column = column(select_o, select_e, select_s, button, width=320, height=1000)
layout_row = row([inputs_column, fig], name="main_row")
curdoc().add_root(layout_row)
