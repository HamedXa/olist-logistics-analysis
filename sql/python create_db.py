import pandas as pd
import sqlite3

conn = sqlite3.connect("olist.db")

files = {
    "orders": "olist_orders_dataset.csv",
    "order_items": "olist_order_items_dataset.csv",
    "customers": "olist_customers_dataset.csv",
    "sellers": "olist_sellers_dataset.csv",
    "products": "olist_products_dataset.csv",
    "reviews": "olist_order_reviews_dataset.csv",
    "payments": "olist_order_payments_dataset.csv",
    "geolocation": "olist_geolocation_dataset.csv"
}

for table_name, filename in files.items():
    df = pd.read_csv(filename)
    df.to_sql(table_name, conn, if_exists="replace", index=False)
    print(f"Loaded {table_name}: {len(df):,} rows")

conn.close()
print("\nolist.db created successfully")