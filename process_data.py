import pandas as pd

DATA_IN_PATH_TEMPLATE = "data/brenda_{}.csv"
DATA_OUT_PATH = 'data/brenda_processed.csv'

def process_data(data_in_path_template: str) -> pd.DataFrame:
    data_parts = []
    for p in range(1, 8):
        data_parts.append(
            pd.read_csv(
                data_in_path_template.format(str(p)),
                sep='\t',
                names=[
                    'ec_number', 'recommended_name', 'measured_km', 'km_transformed',
                    'substrate', 'comments', 'organism', 'primary_accession_number',
                    'structure', 'reference', 'extra_col'
                ],
                header=0,
                na_values = ['additional information', '-'],
                encoding='cp1252'
            )
            .dropna(subset=['measured_km'])
            .drop('extra_col', axis=1)
            .drop_duplicates(subset=['ec_number', 'measured_km'])
        )
    data = pd.concat(data_parts)
    data['ec3'] = data['ec_number'].str.rsplit('.', n=1, expand=True)[0]
    data['ec2'] = data['ec_number'].str.rsplit('.', n=2, expand=True)[0]
    data['ec1'] = data['ec_number'].str.rsplit('.', n=3, expand=True)[0]
    return data

if __name__ == "__main__":
    data = process_data(DATA_IN_PATH_TEMPLATE)
    data.to_csv(DATA_OUT_PATH)


