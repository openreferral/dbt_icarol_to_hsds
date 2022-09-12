with stg_phone as (
    select
        global_source_id,
        time_created,
        id,
        phone_number as number,
        phone_description as description,
        type
    from {{ ref('stg_phone') }}
),

stg_fax as (
    select
        global_source_id,
        time_created,
        id,
        phone_number as number,
        phone_description as description,
        type
    from {{ ref('stg_fax') }}
),

-- Queue up HSDS tables so we can get foreign keys.
service as (
    select
        id,
        source_id
    from {{ ref('service') }}
),

location as (
    select
        id,
        source_id
    from {{ ref('location') }}
),

-- Create phone table for services using inner join.
service_phone as (
    select
        {{ dbt_utils.surrogate_key([
            'stg_phone.global_source_id',
            'stg_phone.id',
            'stg_phone.number',
            'stg_phone.time_created'
        ]) }} as id,
        global_source_id,
        service.id as service_id,
        service.source_id as service_source_id,
        '' as location_id,
        0 as location_source_id,
        number,
        description,
        type
    from stg_phone
    join service
        on service.source_id = stg_phone.id
),

-- Create phone table for locations using inner join.
location_phone as (
    select
        {{ dbt_utils.surrogate_key([
            'stg_phone.global_source_id',
            'stg_phone.id',
            'stg_phone.number',
            'stg_phone.time_created'
        ]) }} as id,
        global_source_id,
        '' as service_id,
        0 as service_source_id,
        location.id as location_id,
        location.source_id as location_source_id,
        number,
        description,
        type
    from stg_phone
    join location
        on location.source_id = stg_phone.id
),

-- Create fax table for services using inner join.
service_fax as (
    select
        {{ dbt_utils.surrogate_key([
            'stg_fax.global_source_id',
            'stg_fax.id',
            'stg_fax.number',
            'stg_fax.time_created'
        ]) }} as id,
        global_source_id,
        service.id as service_id,
        service.source_id as service_source_id,
        '' as location_id,
        0 as location_source_id,
        number,
        description,
        type
    from stg_fax
    join service
        on service.source_id = stg_fax.id
),

-- Create phone table for locations using inner join.
location_fax as (
    select
        {{ dbt_utils.surrogate_key([
            'stg_fax.global_source_id',
            'stg_fax.id',
            'stg_fax.number',
            'stg_fax.time_created'
        ]) }} as id,
        global_source_id,
        '' as service_id,
        0 as service_source_id,
        location.id as location_id,
        location.source_id as location_source_id,
        number,
        description,
        type
    from stg_fax
    join location
        on location.source_id = stg_fax.id
)

-- Combine the service and location tables.
select * from service_phone
union all
select * from location_phone
union all
select * from service_fax
union all
select * from location_fax