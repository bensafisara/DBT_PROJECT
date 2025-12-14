with 

source as (

    select * from {{ source('localbike', 'stores') }}

),

renamed as (

    select
       store_id,
    TRIM(store_name) as store_name ,
    REGEXP_REPLACE(phone, '[^0-9]', '') as phone ,
    LOWER(TRIM(email)) as email ,
    TRIM(street) as street ,
    TRIM(city) as city ,
    UPPER(TRIM(state)) as state,
    zip_code 

    from source

)

select * from renamed