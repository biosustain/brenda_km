import arviz as az
import cmdstanpy
import numpy as np
import pandas as pd
import matplotlib

d = pd.read_csv('DataHydrolases.csv', delimiter = ';',engine='python')
taxa = pd.read_csv('taxonomy.csv', delimiter = ';')
taxa= taxa.iloc[:,1:9]
taxa=taxa.fillna('NAN')
tax = taxa.iloc[:, 7]
org = d.iloc[:, 1]

LinTax = pd.DataFrame()

for i in range(len(org)):
    M= taxa[taxa['species'].str.match(org[i])]
    if M.empty:
        N = taxa[taxa['genus'].str.match(org[i].split(' ', 1)[0])]
        a=N.iloc[[0],1:8]
        a=a.replace(a.iloc[0,6], np.nan)
        a=a.fillna('NAN')
    else:
        a=M.iloc[[0],1:8]
    LinTax=LinTax.append(a)
    
#for i in range(len(org)):
#    M= taxa[taxa['species'].str.match(org[i])]
#    if M.empty:
#        N = taxa[taxa['genus'].str.match(org[i].split(' ', 1)[0])]
#        a=N.iloc[[0],1:8]
#        a=a.replace(a.iloc[[0],6:7],org[i])
#    else:
#        a=M.iloc[[0],1:8]
#    LinTax=LinTax.append(a)
    
d['superkingdom'] = T['superkingdom']
d['family'] = T['family']
d['genus'] = T['genus']
d['species'] = T['species']  

d = d.drop_duplicates()
d = d.reset_index(drop=True)
d = d.drop(['Comments','Organism'], axis=1)


taxa = taxa.append({'tax_id' : '1048575' , 'superkingdom' : 'Eukaryota','phylum' : 'Arthropoda', 'class' : 'Hexanauplia','order' : 'Sessilia','family' : 'Balanidae','genus' : 'Perforatus','species' : 'Perforatus perforatus'} , ignore_index=True)
taxa = taxa.append({'tax_id' : '1048576' , 'superkingdom' : 'Eukaryota','phylum' : 'Arthropoda', 'class' : '	Insecta','order' : 'Hemiptera','family' : 'Cicadidae','genus' : 'Quesada','species' : 'Quesada gigas'} , ignore_index=True)

LinTax = pd.read_csv('LinTax.csv', delimiter = ';',engine='python')
T = pd.read_csv('TaxHOld.csv', delimiter = ';')

indexNames = d[d['species'] == 'NAN'].index
d.drop(indexNames , inplace=True)

T2=T.replace({'NAN': np.nan})

temp = d.iloc[:, 4]
pattern = r'([+-]?\d+(\.\d+)*)\s?°([CcFf])'
pattern = r'\d+°[Cc]'
C = re.findall(pattern, d['Comments'][0])

b = pd.DataFrame(columns=['Temperature'])
for i in range(len(d)):
    y = re.findall(pattern, d['Comments'][i])
    if not y:
       y= np.nan
    else:   
       y=y[0]
    b = np.append(b, y)

d['Temperature'] = b