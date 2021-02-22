import arviz as az
import cmdstanpy
import numpy as np
import pandas as pd
import matplotlib
from matplotlib import pyplot as plt
import re
import nltk

COLS_THAT_MUST_BE_NON_NULL = [
    "Class",
    "Km value",
    "superkingdom",
    "family",
    "genus",
    "species",
]
def one_encode(s: pd.Series) -> pd.Series:
    uniques = s.unique()
    code_map = dict(zip(uniques, range(1, len(uniques) + 1)))
    return s.map(code_map)
d = pd.read_csv('new_taxa.csv', delimiter = ',',engine='python',encoding='utf-8-sig')
d = d.dropna(subset=COLS_THAT_MUST_BE_NON_NULL).reset_index(drop=True)

b = pd.DataFrame(columns=['Temperature'])
#pattern = r'\d+°[Cc]'
pattern = r'(\d+) ?°([Cc])'
for i in range(len(d)):
    y = re.findall(pattern, d['Comments'][i])
    if not y:
       y= np.nan
    else:
       x=y[0]
       y=x[0]
    b = np.append(b, y)

d['Temperature'] = b

d['ec4'] = d['Class']
d['ec3'] = d['ec4'].str.split('.').apply(lambda l: '.'.join(l[:3]))
d['ec2'] = d['ec4'].str.split('.').apply(lambda l: '.'.join(l[:2]))
d['i'] = one_encode(d['ec3'])
d['j'] = one_encode(d['ec4'])
d['k'] = one_encode(d['ec2'])
d['y'] = np.log(d['Km value'])
d['m'] = one_encode(d['Substrate'])
d['x'] = one_encode(d['superkingdom'])
d['f'] = one_encode(d['family'])
d['g'] = one_encode(d['genus'])
d['s'] = one_encode(d['species'])
#d['t'] = one_encode(d['Temperature'])
parent_of_j = d.groupby('j')['i'].first()
parent_of_i = d.groupby('i')['k'].first()
parent_of_f = d.groupby('f')['x'].first()
parent_of_g = d.groupby('g')['f'].first()
parent_of_s = d.groupby('s')['g'].first()

model = cmdstanpy.CmdStanModel(stan_file='Hmodelfull.stan')
#model = cmdstanpy.CmdStanModel(stan_file='HmodelfullSubsTemp.stan')

#model = pystan.StanModel('HECmodel.stan')
#data = {
#    'N': len(d),
#    'I': d['i'].nunique(),
#    'J': d['j'].nunique(),
#    'K': d['k'].nunique(),
#    'O': d['x'].nunique(),
#    'F': d['f'].nunique(),
#    'G': d['g'].nunique(),
#    'S': d['s'].nunique(),
#    'EC3': d['i'].values,
#    'EC4': d['j'].values,
#    'EC2': d['k'].values,
#    'superking': d['x'].values,
#    'family': d['f'].values,
#    'genus': d['g'].values,
#    'species': d['s'].values,
#    'parent_of_EC4': parent_of_j.values,
#    'parent_of_EC3': parent_of_i.values,
#    'parent_of_family': parent_of_f.values,
#    'parent_of_genus': parent_of_g.values,
#    'parent_of_species': parent_of_s.values,
#    'y': d['y'].values,
#    'likelihood': 1
#}

data = {
    'N': len(d),
    'I': d['i'].nunique(),
    'J': d['j'].nunique(),
    'K': d['k'].nunique(),
    'O': d['x'].nunique(),
    'F': d['f'].nunique(),
    'G': d['g'].nunique(),
    'S': d['s'].nunique(),
    'M': d['m'].nunique(),
    'T': d['t'].nunique(),
    'EC3': d['i'].values,
    'EC4': d['j'].values,
    'EC2': d['k'].values,
    'SUBS': d['m'].values,
    'Temp': d['t'].values,
    'superking': d['x'].values,
    'family': d['f'].values,
    'genus': d['g'].values,
    'species': d['s'].values,
    'parent_of_EC4': parent_of_j.values,
    'parent_of_EC3': parent_of_i.values,
    'parent_of_family': parent_of_f.values,
    'parent_of_genus': parent_of_g.values,
    'parent_of_species': parent_of_s.values,
    'y': d['y'].values,
    'likelihood': 1
}

fit = model.sample(data, adapt_delta=0.95, iter_warmup=200, iter_sampling=200,show_progress=True)
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

atemp=infd.posterior['atemp'].to_series().unstack()
f, ax = plt.subplots(figsize=[10, 10])
#plt.xlim(-2, 120)
ax.vlines(tempcols, q[0.025], q[0.975], color="tab:blue")
plt.xlabel('Temperature')
plt.ylabel('posteriors 0.025/0.975 quantiles')

from sklearn.preprocessing import MinMaxScaler
sc = MinMaxScaler()
X_train = d[["Temperature"]].to_numpy()
X_train = sc.fit_transform(X_train)
d['t'] = b
d['t'] = sc.fit_transform(d[['Temperature']])