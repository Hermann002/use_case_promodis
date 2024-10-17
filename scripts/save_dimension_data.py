import pandas as pd
from sqlalchemy import create_engine, text

db_url = "postgresql+psycopg2://hermann:1234@156.67.29.207:4567/promodis_raw_data"
engine = create_engine(db_url)

def save_dimension_data(data_path, table):
    
    data = pd.read_csv(data_path)
    df = pd.DataFrame(data)
    df = pd.DataFrame(data)
    df.columns = df.columns.str.lower()
    with engine.connect() as conn:
        # check the last line of the table in the database
        df.to_sql(table, conn, if_exists="append", index=False)
    
print("chargement de la table client-------------------")
save_dimension_data('./Data/client.csv', 'client')
print("chargement de la table product-------------------")
save_dimension_data('./Data/product.csv', 'product')
print("chargement de la table location-------------------")
save_dimension_data('./Data/location.csv', 'location')
print("chargement de la table MP-------------------")
save_dimension_data('./Data/MP.csv', 'mp')
print("chargement de la table usine-------------------")
save_dimension_data('./Data/usine.csv', 'usine')
print("chargement de la table time-------------------")
save_dimension_data('./Data/time.csv', 'time')
