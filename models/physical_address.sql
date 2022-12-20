select
    tenant_id,
        {{ dbt_utils.surrogate_key([
        'tenant_id',
        'source_location_id',
        '"physical"'
    ]) }} as id,
    id as location_id,
    source_location_id,
    physical_address_1 as address_1,
    physical_city as city,
    physical_region as region,
    physical_state_province as state_province,
    physical_postal_code as postal_code,
    physical_country as country
from {{ ref('stg_location') }}