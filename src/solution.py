import typing
import sqlalchemy
import psycopg2
import pandas as pd
import sys

def connect_to_db() -> sqlalchemy.engine:
    engine = sqlalchemy.create_engine("postgresql+psycopg2://appuser:appuser@localhost:5432/formulary")
    return engine

def load_table_into_dataframe(tablename: str, db_conn: sqlalchemy.engine, columns: str) -> pd.DataFrame:
    query = f"select {columns} from {tablename}"
    with db_conn.connect() as connection:
        data_df = pd.read_sql_query(sql=query, con=connection)
        return data_df

def join_self_tables(df: pd.DataFrame, col: str, condition: typing.Optional[str]) -> pd.DataFrame:
    new_df = df.merge(right=df, on=col, how='inner', suffixes=('_target', ''))

    if condition:
        new_df = new_df.loc[new_df.formulary_id == condition]
    return new_df

if __name__ == "__main__":
    db_conn = connect_to_db()

    if len(sys.argv) == 1:
        tablename = "test_formulary"
    else:
        tablename = "formulary"

    dropped_columns = [
        "tier_level_value_target", 
        "tier_level_value"
    ]

    df_formulary = load_table_into_dataframe(tablename, db_conn, "formulary_id, tier_level_value, rxcui")
    print(f"Table-1: \n{df_formulary}\n")

    if len(sys.argv) == 1:
        print(f"Part 1:\n")
        tableA = join_self_tables(df=df_formulary, col="rxcui", condition=None)

    else:
        print(f"Part 3: `formulary_id` = '{sys.argv[1]}'\n")
        tableA = join_self_tables(df=df_formulary, col="rxcui", condition=f"{sys.argv[1]}")
    
    ## table 2 ##
    print(f"Table-2: \n{tableA}\n")

    ## add tier_difference column ##
    tableA["tier_difference"] = tableA["tier_level_value_target"] - tableA["tier_level_value"]
    print(f"table A add tier diff col \n{tableA}\n")
    tableB = tableA.copy()
    tableB = tableB.loc[tableB.tier_difference != 0]
    print(f"table B add tier diff col \n{tableB}\n")
    
    ## drop cols ##
    tableA.drop(columns=dropped_columns, axis=1, inplace=True)
    print(f"table A drop col \n{tableA}\n")
    tableB.drop(columns=dropped_columns, axis=1, inplace=True)
    print(f"table B drop col \n{tableB}\n")
    
    ## take mean ##
    formularyIdTableA = tableA.groupby("formulary_id").mean(numeric_only=True)
    formularyIdTableB = tableB.groupby("formulary_id").mean(numeric_only=True)
    print(f"Table-3 for A: \n{formularyIdTableA}\n")
    print(f"Table-3 for B: \n{formularyIdTableB}\n")