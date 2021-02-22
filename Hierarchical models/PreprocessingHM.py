import numpy as np
import pandas as pd
TAXA_COLS = [
    "superkingdom", "phylum", "class", "order", "family", "genus", "species"
]
FILEPATH_OUT = "C:\\Users\aretsi\Dropbox\DTU Biosustain\Parameter estimation\Hierarchical models\new_taxa.csv"
FILEPATH_HYDROLASES = "C:\\Users\aretsi\Dropbox\DTU Biosustain\Parameter estimation\Hierarchical models\DataHydrolases.csv"
FILEPATH_TAXONOMY = "C:\\Users\aretsi\Dropbox\DTU Biosustain\Parameter estimation\Hierarchical models\taxonomy.csv"
def main():
    # load raw data
    d = pd.read_csv('DataHydrolases.csv', delimiter = ";", engine="python")
    # load taxa, dropping duplicate rows
    taxa = (
        pd.read_csv('taxonomy.csv', delimiter = ";")
        .drop_duplicates(subset=TAXA_COLS)
    )
    # add taxa information to raw data where the raw data column 'Organsim'
    # matches the taxa column 'species'
    out = d.merge(taxa, left_on="Organism", right_on="species", how="left")
    # write csv file
    out.to_csv('new_taxa.csv',encoding='utf-8-sig')
if __name__ == "__main__":
    main()



