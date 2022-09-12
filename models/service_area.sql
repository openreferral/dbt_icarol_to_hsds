with stg_coverage as (
    select * from {{ ref('stg_coverage') }}
),

service as (
    select
        id,
        source_id
    from {{ ref('service') }}
)

select
    {{ dbt_utils.surrogate_key([
        'stg_coverage.global_source_id',
        'stg_coverage.program_id',
        'stg_coverage.city',
        'stg_coverage.country',
        'stg_coverage.county',
        'stg_coverage.state_province',
        'stg_coverage.postal_code'
    ]) }} as id,
    stg_coverage.global_source_id,
    service.id as service_id,
    service.source_id as service_source_id,
    '{"city":"' || coalesce(stg_coverage.city, '') || '", "country":"' || coalesce(stg_coverage.country, '') || '", "county":"' || coalesce(stg_coverage.county, '') || '", "state_province":"' || coalesce(stg_coverage.state_province, '') || '", "postal_code":"' || coalesce(stg_coverage.postal_code, 0) || '"}' as extent
from stg_coverage
left join service
    on service.source_id = stg_coverage.program_id