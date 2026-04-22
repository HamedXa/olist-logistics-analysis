-- =============================================
-- Olist Logistics Performance — KPI Queries
-- =============================================

-- 1. Headline KPIs
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
AND order_delivered_customer_date IS NOT NULL;

-- 2. Monthly performance trend
SELECT
    STRFTIME('%Y-%m', order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders,
    ROUND(AVG(JULIANDAY(order_delivered_customer_date) - 
              JULIANDAY(order_purchase_timestamp)), 1) AS avg_delivery_days,
    SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date 
        THEN 1 ELSE 0 END) AS late_orders,
    ROUND(SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date 
        THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS late_rate_pct
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
GROUP BY month
ORDER BY month;

-- 3. Late rate by customer state
SELECT
    c.customer_state,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
        THEN 1 ELSE 0 END) AS late_orders,
    ROUND(AVG(JULIANDAY(o.order_delivered_customer_date) - 
              JULIANDAY(o.order_purchase_timestamp)), 1) AS avg_delivery_days,
    ROUND(SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
        THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS late_rate_pct
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY late_rate_pct DESC;

-- 4. Pipeline stage breakdown — where delays happen
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
GROUP BY delivery_status;

-- 5. High value late orders — business impact
SELECT
    o.order_id,
    c.customer_state,
    ROUND(SUM(oi.price), 2) AS order_value,
    ROUND(JULIANDAY(o.order_delivered_customer_date) - 
          JULIANDAY(o.order_estimated_delivery_date), 0) AS days_late,
    ROUND(JULIANDAY(o.order_delivered_customer_date) - 
          JULIANDAY(o.order_purchase_timestamp), 0) AS total_delivery_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date > o.order_estimated_delivery_date
GROUP BY o.order_id, c.customer_state
ORDER BY days_late DESC
LIMIT 20;