with 

source as (

    select * from {{ source('localbike', 'customers') }}

),

renamed as (

    select
    customer_id,
    TRIM(first_name) as first_name,
    TRIM(last_name) as last_name,
    REGEXP_REPLACE(phone, '[^0-9]', '') as phone_clean,
    LOWER(TRIM(email)) as email,
       street,
       city,
        UPPER(TRIM(state)) as state,
        zip_code
    from source

)

select * from renamed