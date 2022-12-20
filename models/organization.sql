select
    description,
    email,
    id,
    legal_status
    name,
    source_organization_id,
    tenant_id,
    url
from {{ ref('stg_organization') }}