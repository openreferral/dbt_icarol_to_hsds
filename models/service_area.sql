with s as (
    select
        id,
        source_service_id
    from {{ ref('stg_service') }}
)

select
    c.id,
    tenant_id,
    s.id as service_id,
    c.source_service_id,
    '{"city":"' || coalesce(city, '') || '", "country":"' || coalesce(country, '') || '", "county":"' || coalesce(county, '') || '", "state_province":"' || coalesce(state_province, '') || '", "postal_code":"' || coalesce(postal_code, 0) || '"}' as extent
from {{ ref('stg_coverage') }} c
join s using(source_service_id)