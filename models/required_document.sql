select
    tenant_id,
    {{ dbt_utils.surrogate_key([
        'tenant_id',
        'source_service_id',
        '"documents_required"'
    ]) }} as id,
    id as service_id,
    source_service_id,
    document
from {{ ref('stg_service') }}
where document is not null
and document <> ''