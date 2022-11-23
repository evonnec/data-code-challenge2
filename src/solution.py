import typing
import sqlalchemy
import psycopg2
import pandas as pd

def connect_to_db(tablename: str) -> sqlalchemy.engine:
    engine = sqlalchemy.create_engine("postgresql+psycopg2://appuser:appuser@localhost:5432/formulary")
    return engine

def load_table_into_dataframe(tablename: str, db_conn: sqlalchemy.engine) -> pd.DataFrame:
    with db_conn.connect() as connection:
        dataDF = pd.read_sql_table(table_name=tablename, con=connection)
        return dataDF



if __name__ == "__main__":
    formulary_db_conn = connect_to_db("formulary")
    test_formulary_db_conn = connect_to_db("test_formulary")
    df = load_table_into_dataframe("formulary", formulary_db_conn)
    print(df)