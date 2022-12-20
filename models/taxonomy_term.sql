select distinct
    tenant_id,
    id,
    term,
    description,
    taxonomy
from {{ ref('stg_taxonomy') }}