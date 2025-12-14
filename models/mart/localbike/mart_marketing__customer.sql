SELECT
    cb.customer_id,
    cb.first_name,
    cb.last_name,
    cb.city,
    cb.state,
    cb.niveau_fidelite,
    cb.total_revenue,
    cb.total_orders,
    cb.avg_order_value,
    cb.recency_days,
    -- Dernière commande 
    cb.last_order_date AS most_recent_purchase,
    -- Recommandation marketing
    CASE
        WHEN cb.recency_days > 90 AND cb.niveau_fidelite IN ('VIP', 'Premium') 
            THEN 'High-Value Reactivation Campaign'
        WHEN cb.total_revenue > 5000 AND cb.recency_days < 30 
            THEN 'Loyalty Program Invitation'
        WHEN cb.total_orders = 1 AND cb.recency_days < 60 
            THEN 'Second Purchase Incentive'
        ELSE 'General Newsletter'
    END AS marketing_recommendation
FROM {{ ref('int_localbike__customer_behavior') }} cb
ORDER BY cb.total_revenue DESC