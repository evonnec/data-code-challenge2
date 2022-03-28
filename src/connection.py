from dataclasses import dataclass

import pandas as pd
import psycopg2
from sqlalchemy import create_engine
from sqlalchemy.engine.base import Connection


@dataclass
class Settings:
    username: str = "appuser"
    password: str = "app-password"
    database_name: str = "formulary_db"


def get_connection(settings: Settings) -> Connection:
    """Create a connection to the database."""
    alchemyEngine = create_engine(
        f'postgresql+psycopg2://{settings.username}:{settings.password}@127.0.0.1/{settings.database_name}',
        pool_recycle=3600
    )
    db_connection = alchemyEngine.connect();
    return db_connection



def get_test_data(db_connection: Connection) -> pd.DataFrame:
    """Test function to confirm access to the data in the database."""
    dataframe = pd.read_sql("select * from test_formulary limit 10;", db_connection)
    return dataframe

