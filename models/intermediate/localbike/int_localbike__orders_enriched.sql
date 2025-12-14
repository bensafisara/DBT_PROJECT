-- -- Fusionne les informations de 3 tables :
-- Commandes + Lignes de commande + Produits

-- -- Calcule pour CHAQUE article vendu :
-- • Revenu avant remise = Prix × Quantité
-- • Revenu après remise = (Prix × Quantité) × (1 - Remise)
-- • Montant de la remise = Prix × Quantité × Remise

WITH order_details AS (
    SELECT
        oi.order_id,
        oi.item_id,
        oi.product_id,
        oi.quantity,
        oi.list_price,
        oi.discount,
        -- Calculs financiers
        oi.list_price * oi.quantity AS revenue_before_discount,
        oi.list_price * oi.quantity * (1 - oi.discount) AS revenue_after_discount,
        oi.list_price * oi.quantity * oi.discount AS total_discount_amount,
        -- Informations de la commande
        o.order_date,
        o.customer_id,
        o.store_id,
        o.staff_id,
        -- Informations produit
        p.product_name,
        p.category_id,
        p.brand_id,
        p.model_year
    FROM {{ ref('stg_localbike__order_items') }} oi
    LEFT JOIN {{ ref('stg_localbike__orders') }} o ON oi.order_id = o.order_id
    LEFT JOIN {{ ref('stg_localbike__products') }} p ON oi.product_id = p.product_id
)

SELECT * FROM order_details