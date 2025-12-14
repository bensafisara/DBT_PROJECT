with 

source as (

    select * from {{ source('localbike', 'orders') }}

),

renamed as (

    select
        order_id,
        customer_id,
        SAFE_CAST (order_date  as DATETIME ) as order_date ,
        SAFE_CAST (required_date as DATETIME ) as required_date ,
        SAFE_CAST (shipped_date as DATETIME )as shipped_date ,
        order_status,
        store_id,
        CAST(staff_id AS STRING) AS staff_id

    from source

)

select * from renamed