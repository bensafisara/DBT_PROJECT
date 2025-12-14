with 
source as (
    select * from {{ source('localbike', 'order_items') }}
),

renamed as (
    select
       CONCAT(order_id, '_', item_id) order_item_id,
        order_id,
        item_id,
        product_id,
        CAST(quantity as INT) as quantity,
        ROUND(list_price, 2) as list_price,
        ROUND(discount, 4) as discount
    from source
)
select * from renamed