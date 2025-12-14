with 

source as (

    select * from {{ source('localbike', 'staffs') }}

),

renamed as (

    select
    CAST(staff_id AS STRING) AS staff_id,
    CAST(manager_id AS STRING) AS manager_id,
    TRIM(first_name) as first_name ,
    TRIM(last_name) as last_name ,
    LOWER(TRIM(email)) as email ,
    REGEXP_REPLACE(phone, '[^0-9]', '') as phone ,
    active,
    store_id

    from source

)

select * from renamed