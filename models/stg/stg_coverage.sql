select
    tenant_id,
    -- Because this table is a 1:many relationship from the service table,
    -- we need to create a surrogate key derived from values. There is no other
    -- way to get a stable primary key.
    {{ dbt_utils.surrogate_key([
        'tenant_id',
        'resource_id',
        'city',
        'country',
        'county',
        'state_province',
        'zip_postal_code'
    ]) }} as id,
    resource_id as source_service_id,
    city,
    country,
    county,
    state_province,
    zip_postal_code as postal_code
from {{ ref('src_coverage' )}}