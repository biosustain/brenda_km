To generate the required priors for the model:
Use the file `modelquery.csv` as input. Run `KmProcessing.py` and this should generate a file called `OUTPUT_FILE.csv` with the mu and sigma of the requested distributions.

To plot the comparison between the priors used in the puplished paper and the priors generated from our model:
Run file `plotdists.m` in Matlab

To run the case study:
Download in the same folder the files `Dataset_S2.csv`, `DatasetN.csv`, `RunModel.m` and `TrypMet.m`. Open in Matlab the file `RunModel.m` and run it.
