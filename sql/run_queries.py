import sqlite3
import pandas as pd

conn = sqlite3.connect("olist.db")
queries = {
    "headline_kpis": """
        SELECT
            COUNT(*) AS total_delivered_orders,
            ROUND(AVG(JULIANDAY(order_delivered_customer_date) - 
                      JULIANDAY(order_purchase_timestamp)), 1) AS avg_delivery_days,
            ROUND(SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date 
                      THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS late_rate_pct,
            ROUND((1 - SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date 
                      THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) * 100, 1) AS on_time_rate_pct
        FROM orders
        WHERE order_status = 'delivered'
        AND order_delivered_customer_date IS NOT NULL
    """,
    "pipeline_breakdown": """
        SELECT
            CASE WHEN order_delivered_customer_date > order_estimated_delivery_date 
                 THEN 'Late' ELSE 'On-time' END AS delivery_status,
            ROUND(AVG(JULIANDAY(order_delivered_carrier_date) - 
                      JULIANDAY(order_purchase_timestamp)), 1) AS avg_carrier_pickup_days,
            ROUND(AVG(JULIANDAY(order_delivered_customer_date) - 
                      JULIANDAY(order_delivered_carrier_date)), 1) AS avg_last_mile_days,
            COUNT(*) AS order_count
        FROM orders
        WHERE order_status = 'delivered'
        AND order_delivered_customer_date IS NOT NULL
        AND order_delivered_carrier_date IS NOT NULL
        GROUP BY delivery_status
    """
}

for name, query in queries.items():
    print(f"\n{'='*40}")
    print(f"{name.upper()}")
    print('='*40)
    print(pd.read_sql_query(query, conn).to_string(index=False))

conn.close()