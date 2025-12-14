with 

source as (

    select * from {{ source('localbike', 'products') }}

),

renamed as (

    select
    product_id,
    TRIM(product_name) as product_name,
    brand_id,
    category_id,
    model_year,
    ROUND(list_price, 2) as list_price
    from source

)

select * from renamed