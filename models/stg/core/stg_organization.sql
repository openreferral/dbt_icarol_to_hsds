
select
    tenant_id,
    id,
    source_id as source_organization_id,
    public_name as name,
    alternate_name as alternate_name,
    agency_description as description,
    email_address_main as email,
    website_address as url,
    legal_status as legal_status
from {{ ref('src_resource' ) }}
where table_name = 'Agency'