# How to reproduce our case study results

## Preliminaries
- Make sure you have Matlab installed with the Statistics and machine learning
  add-on.

## Generate the required priors for the model
- Make sure the files `modelquery.csv` and `KmProcessing.py` are in the same directory.
- Run the Python script `KmProcessing.py`. This should generate a file called
  `Pred_Priors.csv` with the mu and sigma of the requested distributions.

## Generate Plots comparing our priors and those in the comparison paper
- Make sure the files `Dataset_S2.csv` and `Pred_Priors.csv` are in the same directory.
- Run the file `plotdists.m` with Matlab. This will plot the new distributions together with the published ones. It will also create a dataset `DataseN.csv` by sampling from the new distributions, which can be used to run the case study. This dataset can be saved (overwriting the existing `DataseN.csv`) by uncommenting the relevant code at the end of the script.

## Run the case study
- Make sure the files `Dataset_S2.csv`, `DataseN.csv` and `TrypMet.m` are in the same directory.
- Run the file `RunModel.m` with Matlab. This will run the model by using both parameter sets (published and new) and generate the plots of the results.

# How to generate priors for your model
- Update the content of the file `modelquery.csv` according to the requirements of your model. 
- In the Python script `KmProcessing.py` change the input "ORGANISM" to the organism you are modelling.
- Make sure the files `modelquery.csv` and `KmProcessing.py` are in the same directory.
- Run the Python script `KmProcessing.py`. This will generate the `Pred_Priors.csv` file 
  with the mu and sigma of the requested distributions.
