with o as (
    select
        id,
        source_organization_id
    from {{ ref('stg_organization') }}
)

select
    alternate_name,
    application_process,
    description,
    email,
    fees,
    name,
    o.id as organization_id,
    s.id,
    s.source_organization_id,
    source_service_id,
    tenant_id,
    url
from {{ ref('stg_service') }} s
join o using(source_organization_id)
    where o.id is not null