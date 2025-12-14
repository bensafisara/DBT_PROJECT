with 

source as (

    select * from {{ source('localbike', 'stocks') }}

),

renamed as (

    select
        CONCAT(store_id,'_',product_id) as stocks_id,
        store_id,
        product_id,
        quantity

    from source

)

select * from renamed