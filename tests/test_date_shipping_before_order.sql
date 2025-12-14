{{ config(severity='warn') }}
--livraison avant commande
SELECT order_id
FROM {{ ref('stg_localbike__orders') }}
where SAFE_CAST(shipped_date AS DATE) < SAFE_CAST(order_date AS DATE)