with 

source as (

    select * from {{ source('localbike', 'categories') }}

),

renamed as (

    select
        category_id,
        TRIM(category_name) as category_name

    from source

)

select * from renamed