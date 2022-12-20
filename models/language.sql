select
    tenant_id,
    {{ dbt_utils.surrogate_key([
        'tenant_id',
        'source_service_id',
        '"languages_offered"'
    ]) }} as id,
    id as service_id,
    source_service_id,
    language
from {{ ref('stg_service') }}
    where language is not null
    and language <> ''