select
    tenant_id,
    {{ dbt_utils.surrogate_key([
        'tenant_id',
        'source_service_id',
        '"eligibility"'
    ]) }} as id,
    id as service_id,
    source_service_id,
    eligibility
from {{ ref('stg_service') }}
    where eligibility is not null
    and eligibility <> ''