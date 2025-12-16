SELECT
    DATE_TRUNC(o.order_date, MONTH) AS revenue_month,
    s.store_name,
    s.state AS store_state,
    c.category_name,
    b.brand_name,
    -- Métriques financières
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.list_price * oi.quantity),2 ) AS gross_revenue,
    ROUND(SUM(oi.list_price * oi.quantity * oi.discount),2 ) AS total_discounts,
    ROUND(SUM(oi.list_price * oi.quantity * (1 - oi.discount)),2 ) AS net_revenue,
    -- Calcul de la marge (hypothèse - à adapter avec ton coût réel)
    ROUND(SUM(oi.list_price * oi.quantity * (1 - oi.discount) * 0.6),2 ) AS estimated_profit,
    -- KPI
    ROUND(SUM(oi.list_price * oi.quantity * (1 - oi.discount)) / COUNT(DISTINCT o.order_id),2 ) AS avg_order_value
FROM {{ ref('int_localbike__orders_enriched') }} oe
LEFT JOIN {{ ref('stg_localbike__stores') }} s ON oe.store_id = s.store_id
LEFT JOIN {{ ref('stg_localbike__categories') }} c ON oe.category_id = c.category_id
LEFT JOIN {{ ref('stg_localbike__brands') }} b ON oe.brand_id = b.brand_id
LEFT JOIN {{ ref('stg_localbike__orders') }} o ON oe.order_id = o.order_id
LEFT JOIN {{ ref('stg_localbike__order_items') }} oi ON oe.order_id = oi.order_id
GROUP BY 1, 2, 3, 4, 5
ORDER BY revenue_month DESC, net_revenue DESC