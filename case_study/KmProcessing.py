import numpy as np
import pandas as pd
# from functools import partial
# from Lognormparam import get_lognormal_params_from_qs

modelquery = pd.read_csv('modelquery.csv', delimiter = ';')
BrendaRes = pd.read_csv('posterior_summary_brenda.csv', delimiter = ',')
BrendaRes=BrendaRes.drop(labels='biology', axis=1)
# BrendaRes['posterior_mean'] = np.exp(BrendaRes['posterior_mean'])
# BrendaRes['q_0.01'] = np.exp(BrendaRes['q_0.01'])
# BrendaRes['q_0.5'] = np.exp(BrendaRes['q_0.5'])
# BrendaRes['q_0.99'] = np.exp(BrendaRes['q_0.99'])

ECnum = modelquery.iloc[:, 1]
Subs = modelquery.iloc[:, 2]
Org = modelquery.iloc[0, 3]
Posteriors = pd.DataFrame()

for i in range(len(modelquery)):
    M= BrendaRes[BrendaRes['biology_ec4'].str.match(ECnum[i])]
    a=M.iloc[:,1:10]
    D=a[a['biology_substrate'].str.match(Subs[i])]
    if D.empty:
        b=a[a['biology_organism'].str.match(Org)]
        if b.empty:
            Posteriors=Posteriors.append(a)
        else:
            Posteriors=Posteriors.append(b)
    else:
        b=D[D['biology_organism'].str.match(Org)]
        if b.empty:
            Posteriors=Posteriors.append(D)
        else:
            Posteriors=Posteriors.append(b)

for j in range(len(Posteriors)):
    mu=Posteriors.iloc[j].at["q_0.5"]
    sigma=np.sqrt(2*Posteriors.iloc[j].at["posterior_mean"]-mu)
    MU=mu.append(mu)
    S=sigma.append(sigma)
    
# f = partial(get_lognormal_params_from_qs, p1=0.01, p2=0.99)
# mu_and_sigma = (
#     Posteriors.apply(lambda row: f(row["q_0.01"], row["q_0.99"]), axis=1)
#     .pipe(pd.DataFrame.from_records, columns=["mu", "sigma"])
# )
 
Posteriors.to_csv('Pred_Priors.csv',encoding='utf-8-sig')

#b = a.str.contains('Trypanosoma', regex=False)