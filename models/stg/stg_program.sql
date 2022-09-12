select
    "{{ var('global_source_id') }}" as global_source_id,
    time_created,
    resource_agency_num as id,
    parent_agency_num as organization_source_id,
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