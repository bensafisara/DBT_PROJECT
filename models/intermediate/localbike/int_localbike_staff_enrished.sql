SELECT
        st.staff_id,
        CONCAT(st.first_name, ' ', st.last_name) AS staff_name,
        s.store_name,
        st.manager_id,
        CONCAT(mgr.first_name, ' ', mgr.last_name) AS manager_name,
        DATE_TRUNC( o.order_date , MONTH) AS sales_month,
        -- Performance commerciale
        COUNT(DISTINCT o.order_id) AS orders_processed,
        COUNT(DISTINCT o.customer_id) AS unique_customers_served,
        SUM(oi.quantity) AS total_items_sold,
        ROUND(SUM(oi.list_price * oi.quantity * (1 - oi.discount)),2) AS total_revenue_generated,
        -- Métriques de satisfaction (hypothèse basée sur les retours)
        ROUND(AVG(CASE WHEN o.order_status = 4 THEN 1 ELSE 0 END) ,2)AS delivery_success_rate,
        ROUND(AVG(DATE_DIFF(o.shipped_date, o.order_date, DAY)),2) AS avg_shipping_time_days
    FROM {{ ref('stg_localbike__staffs') }} st
    LEFT JOIN {{ ref('stg_localbike__staffs') }} mgr ON st.manager_id = mgr.staff_id
    LEFT JOIN {{ ref('stg_localbike__stores') }} s ON st.store_id = s.store_id
    LEFT JOIN {{ ref('stg_localbike__orders') }} o ON st.staff_id = o.staff_id
    LEFT JOIN {{ ref('stg_localbike__order_items') }} oi ON o.order_id = oi.order_id
    WHERE o.order_date IS NOT NULL
    GROUP BY 1, 2, 3, 4, 5, 6

