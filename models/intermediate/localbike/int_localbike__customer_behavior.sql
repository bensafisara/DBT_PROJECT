WITH customer_orders AS (
    SELECT
        o.customer_id,
        c.first_name,
        c.last_name,
        c.city,
        c.state,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.quantity) AS total_items_purchased,
        ROUND(SUM(oi.list_price * oi.quantity * (1 - oi.discount)), 2)   AS total_revenue,
        MIN(o.order_date) AS first_order_date,
        MAX(o.order_date) AS last_order_date,
        ROUND(AVG(oi.list_price * oi.quantity * (1 - oi.discount)), 2)  AS avg_order_value
    FROM {{ ref('stg_localbike__orders') }} o
    LEFT JOIN {{ ref('stg_localbike__order_items') }} oi ON o.order_id = oi.order_id
    LEFT JOIN {{ ref('stg_localbike__customers') }} c ON o.customer_id = c.customer_id
    GROUP BY         
        o.customer_id,
        c.first_name,
        c.last_name,
        c.city,
        c.state
)SELECT
        *
        ,
        -- Calcul du segment RFM (Recency, Frequency, Monetary)
        DATE_DIFF(CURRENT_DATE(), last_order_date, DAY) AS recency_days,
        total_orders AS frequency,
        total_revenue AS monetary,
        -- Segment basé sur la valeur
        CASE
            WHEN total_revenue > 10000 THEN 'VIP'
            WHEN total_revenue BETWEEN 5000 AND 10000 THEN 'Premium'
            WHEN total_revenue BETWEEN 1000 AND 5000 THEN 'Regular'
            ELSE 'Occasional'
        END AS niveau_fidelite
    FROM customer_orders
