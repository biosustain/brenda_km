"""Some handy python functions."""

import pandas as pd


def one_encode(s: pd.Series) -> pd.Series:
    """Replace a series's values with 1-indexed integer factors.

    :param s: a pandas Series that you want to factorise.

    """
    return pd.Series(pd.factorize(s)[0] + 1, index=s.index)


def make_columns_lower_case(df: pd.DataFrame) -> pd.DataFrame:
    """Make a DataFrame's columns lower case.

    :param df: a pandas DataFrame
    """
    new = df.copy()
    new.columns = [c.lower() for c in new.columns]
    return new


def flatten_columns(df: pd.DataFrame, sep="_") -> pd.DataFrame:
    """Flatten the columns of a dataframe.

    This is nice to do because in my opinion MultiIndexes are often quite
    annoying.

    """
    assert isinstance(
        df.columns, pd.MultiIndex
    ), "Not enough levels to flatten!"
    new_column_values = df.columns.get_level_values(0)
    new_columns_name = df.columns.names[0]
    for i in range(len(df.columns.levels) - 1):
        iplusone_vals = df.columns.get_level_values(i + 1)
        iplusone_name = df.columns.names[i + 1]
        new_column_values = [
            f"{v_i}{sep}{v_iplusone}"
            for v_i, v_iplusone in zip(new_column_values, iplusone_vals)
        ]
        new_columns_name = f"{new_columns_name}{sep}{iplusone_name}"
    new_columns = pd.Index(new_column_values, name=new_columns_name)
    return pd.DataFrame(df, columns=new_columns)
