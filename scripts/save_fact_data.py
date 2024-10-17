import pandas as pd
from sqlalchemy import create_engine, text

db_url = "postgresql+psycopg2://hermann:1234@156.67.29.207:4567/promodis_raw_data"
engine = create_engine(db_url)

def save_fact_data(data_path, table, columns):
    
    with engine.connect() as conn:
        # check the last line of the table in the database
        try:
            last_id = conn.execute(text(f"SELECT {table}ID FROM {table} ORDER BY {table}ID DESC LIMIT 1")).fetchone()[0]
            index_start = last_id-98
            data = pd.read_csv(data_path, skiprows=index_start, names=columns, header=None)
            print(data)
        except Exception as e:
            print(e)
            data = pd.read_csv(data_path)
        df = pd.DataFrame(data)
        df.columns = df.columns.str.lower()
        print(df.head())
        conn.close()

    with engine.connect() as conn:
        df.to_sql(table, conn, if_exists="append", index=False)

print("chargement de la table vente-------------------")
save_fact_data('./Data/ventes.csv', 'vente', ["venteID", "productID", "clientID", "salesDate", "salesVolume", "salesAmount", "locationID"])
print("chargement de la table fabrication-------------------")
save_fact_data('./Data/fabrication.csv', 'fabrication', ["fabricationID",	"productID", "usineID",	"MPID",	"dateProduction", "quantiteProduite", "quantiteConditionnee", "ecartFabrication", "ecartConditionnement", "quantiteMP"])
print("chargement de la table retour-------------------")
save_fact_data('./Data/retours.csv', 'retour', ["retourid", "productid", "usineid", "dateretour", "quantiteretournee"])
print("chargement de la table distribution-------------------")
save_fact_data('./Data/distribution.csv', 'distribution', ["distributionID", "productID",	"clientID",	"distributionDate",	"quantity",	"locationID"])