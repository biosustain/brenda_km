# How to reproduce our case study results

## Preliminaries
- Make sure you have Matlab installed with the Statistics and machine learning
  add-on.

## Generate the required priors for the model
- Run the Python script `KmProcessing.py`. This should generate a file called
  `Pred_Priors.csv` with the mu and sigma of the requested distributions.

## Generate Plots comparing our priors and those in the comparison paper
- Run the file `plotdists.m` with Matlab

## Run the case study
- Run the file `RunModel.m` with Matlab
