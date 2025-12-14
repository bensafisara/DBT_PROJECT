
    SELECT
        *,
        RANK() OVER (PARTITION BY sales_month ORDER BY total_revenue_generated DESC) AS revenue_rank_monthly,
        RANK() OVER (PARTITION BY store_name ORDER BY total_revenue_generated DESC) AS revenue_rank_store,
        -- Croissance mensuelle
        LAG(total_revenue_generated) OVER (PARTITION BY staff_id ORDER BY sales_month) AS prev_month_revenue,
        CASE
            WHEN LAG(total_revenue_generated) OVER (PARTITION BY staff_id ORDER BY sales_month) > 0
            THEN (total_revenue_generated - LAG(total_revenue_generated) OVER (PARTITION BY staff_id ORDER BY sales_month)) 
                 / LAG(total_revenue_generated) OVER (PARTITION BY staff_id ORDER BY sales_month) * 100
            ELSE NULL
        END AS monthly_growth_percent
    FROM {{ ref('int_localbike_staff_enrished') }}
ORDER BY sales_month DESC, revenue_rank_monthly