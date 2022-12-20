with s as (
    select
        id,
        source_service_id
    from {{ ref('stg_service') }}
),

l as (
    select
        id,
        source_location_id
    from {{ ref('stg_location') }}
)

select
    tenant_id,
    r.id,
    source_id as source_service_at_location_id,
    l.id as location_id,
    connects_to_site_num as source_location_id,
    s.id as service_id,
    connects_to_program_num as source_service_id
from {{ ref('src_resource' ) }} r
join s on s.source_service_id = connects_to_program_num
join l on l.source_location_id = connects_to_site_num