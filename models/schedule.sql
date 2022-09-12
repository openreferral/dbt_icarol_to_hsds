with stg_hours as (
    select
        global_source_id,
        time_created,
        id,
        description
    from {{ ref('stg_hours') }}
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
)

-- Create the schedule table with foreign keys to location and service.
select
    {{ dbt_utils.surrogate_key([
        'stg_hours.global_source_id',
        'stg_hours.id',
        'stg_hours.description',
        'stg_hours.time_created'
    ]) }} as id,
    global_source_id,
    coalesce(service.id) as service_id,
    coalesce(service.source_id) as service_source_id,
    coalesce(location.id) as location_id,
    coalesce(location.source_id) as location_source_id,
    stg_hours.description
from stg_hours
left join service
    on service.source_id = stg_hours.id
left join location
    on location.source_id = stg_hours.id
where stg_hours.description is not null
and stg_hours.description <> ''