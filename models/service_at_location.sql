with sal as (
    select
        global_source_id,
        id,
        connects_to_site_num as location_source_id,
        connects_to_program_num as service_source_id
    from {{ ref('stg_program_site') }}
),

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

select
    {{ dbt_utils.surrogate_key([
        'sal.global_source_id',
        'sal.id',
        'service.id',
        'location.id'
    ]) }} as id,
    sal.global_source_id,
    service.id as service_id,
    sal.service_source_id,
    location.id as location_id,
    sal.location_source_id
from sal
join service
    on sal.service_source_id = service.source_id
join location
    on sal.location_source_id = location.source_id