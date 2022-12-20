select
    tenant_id,
    id,
    source_id as source_location_id,
    parent_agency_num as source_organization_id,
    public_name as name,
    alternate_name as alternate_name,
    agency_description as description,
    coalesce(
        concat(physical_address_1, ', ', physical_address_2),
        physical_address_1,
        ''
    ) as physical_address_1,
    physical_city,
    physical_county as physical_region,
    physical_state_province,
    physical_postal_code,
    physical_country,
    physical_address_is_private,
    coalesce(
        concat(mailing_address_1, ', ', mailing_address_2),
        mailing_address_1,
        ''
    ) as mailing_address_1,
    mailing_city,
    mailing_state_province,
    mailing_postal_code,
    mailing_country,
    mailing_address_is_private,
    latitude,
    longitude
from {{ ref('src_resource' ) }}
    where table_name = 'Site'