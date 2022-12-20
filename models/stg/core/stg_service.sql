select
    tenant_id,
    id,
    source_id as source_service_id,
    parent_agency_num as source_organization_id,
    public_name as name,
    alternate_name as alternate_name,
    agency_description as description,
    email_address_main as email,
    website_address as url,
    eligibility,
    fee_structure_source as fees,
    application_process as application_process,
    documents_required as document,
    languages_offered as language
from {{ ref('src_resource' ) }}
where table_name = 'Program'