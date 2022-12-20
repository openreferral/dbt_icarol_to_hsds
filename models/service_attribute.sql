with s as (
    select
        id,
        source_service_id
    from {{ ref('stg_service') }}
)

select
    {{ dbt_utils.surrogate_key([
        'tenant_id',
        'source_service_id',
        'term'
    ]) }} as id,
    tenant_id,
    t.id as taxonomy_term_id,
    t.source_service_id,
    s.id as service_id
from {{ ref('stg_taxonomy') }} t
join s using(source_service_id)