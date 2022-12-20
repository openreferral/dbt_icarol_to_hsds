with o as (
    select
        id,
        source_organization_id
    from {{ ref('stg_organization') }}
)

select
    tenant_id,
    l.id,
    source_location_id,
    alternate_name,
    description,
    latitude,
    longitude,
    name,
    o.id as organization_id,
    l.source_organization_id
from {{ ref('stg_location') }} l
join o using(source_organization_id)
    where o.id is not null