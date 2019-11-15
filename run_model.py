import pandas as pd
import cmdstanpy
import arviz as az
from matplotlib import pyplot as plt
import numpy as np

plt.style.use('sparse.mplstyle')

ENZYME_MODEL_PATH = 'enzyme_model.stan'
EC3_MODEL_PATH = 'ec3_model.stan'
DATA_PATH = 'data/brenda_processed.csv'
ORGANISM = 'Saccharomyces cerevisiae'

def get_data_df(data_path = DATA_PATH, organism=ORGANISM):
    return (
        pd.read_csv(data_path)
        .loc[lambda df: df['organism'] == organism]
        .assign(
            log_measured_km=lambda df: np.log(df['measured_km']),
            ec3_stan=lambda df: df['ec3'].factorize()[0] + 1,
            ec4_stan=lambda df: df['ec_number'].factorize()[0] + 1
        )
    )

def run_enzyme_model(data_df):
    model = cmdstanpy.CmdStanModel(stan_file=ENZYME_MODEL_PATH)
    model.compile()
    input_base = {
        'N': len(data_df),
        'E': data_df['ec4_stan'].nunique(),
        'enzyme': data_df['ec4_stan'].values,
        'log_km_obs': data_df['log_measured_km'].values,
    }
    input_prior = {**input_base, **{'likelihood': 0}}
    input_posterior = {**input_base, **{'likelihood': 1}}

    fit_prior = model.sample(data=input_prior, adapt_delta=0.999, max_treedepth=12)
    fit_prior.diagnose()
    fit_posterior = model.sample(data=input_posterior, adapt_delta=0.999, max_treedepth=12)
    fit_posterior.diagnose()
    infd_prior, infd_posterior = (
        az.from_cmdstanpy(
            fit,
            coords={'enzyme_labels': data_df.groupby('ec4_stan')['ec_number'].first().values},
            dims={'mu_enzyme': ['enzyme_labels']},
            log_likelihood='log_likelihood'
        )
        for fit in [fit_prior, fit_posterior]
    )
    return fit_prior, fit_posterior, infd_prior, infd_posterior


def run_ec3_model(data_df):
    model = cmdstanpy.CmdStanModel(stan_file=EC3_MODEL_PATH)
    model.compile()
    input_base = {
        'N': len(data_df),
        'E': data_df['ec4_stan'].nunique(),
        'EC3': data_df['ec3_stan'].nunique(),
        'enzyme': data_df['ec4_stan'].values,
        'ec3': data_df.groupby('ec4_stan')['ec3_stan'].first().values,
        'log_km_obs': data_df['log_measured_km'].values,
    }
    input_prior = {**input_base, **{'likelihood': 0}}
    input_posterior = {**input_base, **{'likelihood': 1}}
    fit_prior = model.sample(data=input_prior, adapt_delta=0.999, max_treedepth=12)
    fit_prior.diagnose()
    fit_posterior = model.sample(data=input_posterior, adapt_delta=0.999, max_treedepth=12)
    fit_posterior.diagnose()
    infd_prior, infd_posterior = (
        az.from_cmdstanpy(
            fit,
            coords={
                'enzyme_labels': data_df.groupby('ec4_stan')['ec_number'].first().values,
                'ec3_labels': data_df.groupby('ec3_stan')['ec3'].first().values
            },
            dims={'mu_enzyme': ['enzyme_labels'], 'mu_ec3': ['ec3_labels'], 'sigma_ec3': ['ec3_labels']},
            log_likelihood='log_likelihood'
        )
        for fit in [fit_prior, fit_posterior]
    )
    return fit_prior, fit_posterior, infd_prior, infd_posterior

def plot_forest(ax, df, low=0.1, high=0.9, color='tab:blue', alpha=0.5):
    ytick_locations = []
    for i, colname in enumerate(df.columns):
        ytick_locations.append(i)
        col = df[colname]
        ax.plot([col.quantile(low), col.quantile(high)], [i, i], color=color, alpha=alpha)
        ax.plot(col.quantile(0.5), i, color=color)
    ax.set_yticks(ytick_locations)
    ax.set_yticklabels(df.columns)
    return ax


def plot_param_forest(infd_prior, infd_posterior, par, ax):
    samples_prior, samples_posterior = (
        p[par].to_series().unstack().pipe(sort_by_median)
        for p in [infd_prior.posterior, infd_posterior.posterior]
    )
    plot_forest(ax, samples_prior, color='tab:orange')
    plot_forest(ax, samples_posterior)
    ax.set_xlabel(par)
    return ax


def sort_by_median(df, axis=1):
    return df.reindex(df.median().sort_values().index, axis=axis)


def main():
    # get data
    data_df = get_data_df()

    # run models
    _, _, infd_prior_enzyme, infd_posterior_enzyme = run_enzyme_model(data_df)
    _, _, infd_prior_ec3, infd_posterior_ec3 = run_ec3_model(data_df)

    # draw plots
    f, ax = plt.subplots(figsize=[10, 25])
    ax = plot_param_forest(infd_prior_ec3, infd_posterior_ec3, 'log_sigma_ec3', ax)
    plt.savefig('sigma_forest.png')
    plt.close('all')


if __name__ == '__main__':
    main()



