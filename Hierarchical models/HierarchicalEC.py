#import pystan
import arviz as az
import cmdstanpy
import numpy as np
import pandas as pd
import matplotlib
#matplotlib.use('TkAgg')
from matplotlib import pyplot as plt

def one_encode(s: pd.Series) -> pd.Series:
    uniques = s.unique()
    code_map = dict(zip(uniques, range(1, len(uniques) + 1)))
    return s.map(code_map)

d = pd.read_csv('Data.csv', delimiter = ';')
d['ec4'] = d['Class']
d['ec3'] = d['ec4'].str.split('.').apply(lambda l: '.'.join(l[:3]))
d['ec2'] = d['ec4'].str.split('.').apply(lambda l: '.'.join(l[:2]))
d['i'] = one_encode(d['ec3'])
d['j'] = one_encode(d['ec4'])
d['k'] = one_encode(d['ec2'])
d['m'] = one_encode(d['Substrate'])
d['y'] = np.log(d['Km value'])

T = pd.read_csv('Tax.csv', delimiter = ';')
T['x'] = one_encode(T['superkingdom'])
T['f'] = one_encode(T['family'])
T['g'] = one_encode(T['genus'])
T['s'] = one_encode(T['species'])

parent_of_j = d.groupby('j')['i'].first()
parent_of_i = d.groupby('i')['k'].first()
parent_of_f = T.groupby('f')['x'].first()
parent_of_g = T.groupby('g')['f'].first()
parent_of_s = T.groupby('s')['g'].first()

model = cmdstanpy.CmdStanModel('Hmodelfull.stan')
model = cmdstanpy.CmdStanModel('HSmodel.stan')
#model = pystan.StanModel('HECmodel.stan')
data = {
    'N': len(d),
    'I': d['i'].nunique(),
    'J': d['j'].nunique(),
    'K': d['k'].nunique(),
    'O': T['x'].nunique(),
    'F': T['f'].nunique(),
    'G': T['g'].nunique(),
    'S': T['s'].nunique(),
    'M': d['m'].nunique(),
    'EC3': d['i'].values,
    'EC4': d['j'].values,
    'EC2': d['k'].values,
    'SUBS': d['m'].values,
    'superking': T['x'].values,
    'family': T['f'].values,
    'genus': T['g'].values,
    'species': T['s'].values,
    'parent_of_EC4': parent_of_j.values,
    'parent_of_EC3': parent_of_i.values,
    'parent_of_family': parent_of_f.values,
    'parent_of_genus': parent_of_g.values,
    'parent_of_species': parent_of_s.values,
    'y': d['y'].values,
    'likelihood': 1
}
fit = model.sample(data, adapt_delta=0.95, warmup_iters=200)
fit.diagnose()
#fit = model.sample(data, adapt_delta=0.95,output_dir=".") #use when there is error

infd = az.from_cmdstanpy(fit, log_likelihood='log_likelihood')
loo_results = az.loo(infd, scale='log', pointwise=True)
d['khat'] = loo_results.pareto_k.values
d['loo'] = loo_results.loo_i.values

samples = fit.get_drawset()
ppc = (
    infd.posterior['yrep']
    .quantile([0.05, 0.5, 0.95], dim=['chain', 'draw'])
    .to_series()
    .unstack()
    .T
)
ppc.columns = ['low', 'med', 'high']
d=d.join(ppc)
ppc = ppc.join(d[['y', 'khat', 'loo']])
f, ax = plt.subplots(figsize=[10, 10])
plt.title('Predicted vs Actual values (Hierarchical Model)')
plt.xlabel('Predicted values')
plt.ylabel('Actual values')
ax.scatter(ppc['med'], ppc['y'], c=ppc['khat'], cmap=matplotlib.cm.viridis)
ax.vlines(ppc['med'], ppc['low'], ppc['high'], zorder=0, color='gainsboro')
ax.plot(ppc['med'], ppc['med'], color='r')

aEC2=infd.posterior['aEC2'].to_series().unstack()
aEC2.mean()
aEC3=infd.posterior['aEC3'].to_series().unstack()
aEC3.mean()
aEC4=infd.posterior['aEC4'].to_series().unstack()
aEC4.mean()
tauEC2=infd.posterior['tauEC2'].to_series().unstack()
tauEC2.mean()
tauEC3=infd.posterior['tauEC3'].to_series().unstack()
tauEC3.mean()
tauEC4=infd.posterior['tauEC4'].to_series().unstack()
tauEC4.mean()

#Model comparison
model1 = cmdstanpy.CmdStanModel('HEC1model.stan')
fit1 = model1.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd1 = az.from_cmdstanpy(fit1, log_likelihood='log_likelihood')
loo1 = az.loo(infd1, scale='log', pointwise=True)
model2 = cmdstanpy.CmdStanModel('HEC2model.stan')
fit2 = model1.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd2 = az.from_cmdstanpy(fit2, log_likelihood='log_likelihood')
loo2 = az.loo(infd2, scale='log', pointwise=True)
model3 = cmdstanpy.CmdStanModel('HEC3model.stan')
fit3 = model3.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd3 = az.from_cmdstanpy(fit3, log_likelihood='log_likelihood')
loo3 = az.loo(infd3, scale='log', pointwise=True)
model4 = cmdstanpy.CmdStanModel('HEC3O1model.stan')
fit4 = model4.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd4 = az.from_cmdstanpy(fit4, log_likelihood='log_likelihood')
loo4 = az.loo(infd4, scale='log', pointwise=True)
model5 = cmdstanpy.CmdStanModel('HEC3O2model.stan')
fit5 = model5.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd5 = az.from_cmdstanpy(fit5, log_likelihood='log_likelihood')
loo5 = az.loo(infd5, scale='log', pointwise=True)
model6 = cmdstanpy.CmdStanModel('HEC3O3model.stan')
fit6 = model6.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd6 = az.from_cmdstanpy(fit6, log_likelihood='log_likelihood')
loo6 = az.loo(infd6, scale='log', pointwise=True)
model7 = cmdstanpy.CmdStanModel('HEC1O1model.stan')
fit7 = model7.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd7 = az.from_cmdstanpy(fit7, log_likelihood='log_likelihood')
loo7 = az.loo(infd7, scale='log', pointwise=True)
model8 = cmdstanpy.CmdStanModel('Hmodelfull.stan')
fit8 = model8.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd8 = az.from_cmdstanpy(fit8, log_likelihood='log_likelihood')
loo8 = az.loo(infd8, scale='log', pointwise=True)



model1 = cmdstanpy.CmdStanModel('HEC1Rmodel.stan')
fit1 = model1.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd1 = az.from_cmdstanpy(fit1, log_likelihood='log_likelihood')
loo1 = az.loo(infd1, scale='log', pointwise=True)
model2 = cmdstanpy.CmdStanModel('HEC2Rmodel.stan')
fit2 = model1.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd2 = az.from_cmdstanpy(fit2, log_likelihood='log_likelihood')
loo2 = az.loo(infd2, scale='log', pointwise=True)
model3 = cmdstanpy.CmdStanModel('HEC3model.stan')
fit3 = model3.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd3 = az.from_cmdstanpy(fit3, log_likelihood='log_likelihood')
loo3 = az.loo(infd3, scale='log', pointwise=True)

model4 = cmdstanpy.CmdStanModel('HO1skmodel.stan')
fit4 = model4.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd4 = az.from_cmdstanpy(fit4, log_likelihood='log_likelihood')
loo4 = az.loo(infd4, scale='log', pointwise=True)
model5 = cmdstanpy.CmdStanModel('HO2skmodel.stan')
fit5 = model5.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd5 = az.from_cmdstanpy(fit5, log_likelihood='log_likelihood')
loo5 = az.loo(infd5, scale='log', pointwise=True)
model6 = cmdstanpy.CmdStanModel('HO3skmodel.stan')
fit6 = model6.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd6 = az.from_cmdstanpy(fit6, log_likelihood='log_likelihood')
loo6 = az.loo(infd6, scale='log', pointwise=True)
model7 = cmdstanpy.CmdStanModel('HO4skmodel.stan')
fit7 = model7.sample(data, adapt_delta=0.95, warmup_iters=2000)
infd7 = az.from_cmdstanpy(fit7, log_likelihood='log_likelihood')
loo7 = az.loo(infd7, scale='log', pointwise=True)


samples = fit8.get_drawset()
ppc = (
    infd8.posterior['yrep']
    .quantile([0.05, 0.5, 0.95], dim=['chain', 'draw'])
    .to_series()
    .unstack()
    .T
)
ppc.columns = ['low', 'med', 'high']
d['khat'] = loo8.pareto_k.values
d['loo'] = loo8.loo_i.values
ppc = ppc.join(d[['y', 'khat', 'loo']])
f, ax = plt.subplots(figsize=[10, 10])
plt.title('Predicted vs Actual values (Hierarchical Model)')
plt.xlabel('Predicted values')
plt.ylabel('Actual values')
ax.scatter(ppc['med'], ppc['y'], c=ppc['khat'], cmap=matplotlib.cm.viridis)
ax.vlines(ppc['med'], ppc['low'], ppc['high'], zorder=0, color='gainsboro')
ax.plot(ppc['med'], ppc['med'], color='r')