select
    tenant_id,
    {{ dbt_utils.surrogate_key([
        'tenant_id',
        'source_location_id',
        '"postal"',
    ]) }} as id,
    id as location_id,
    source_location_id,
    mailing_address_1 as address_1,
    mailing_city as city,
    mailing_state_province as state_province,
    mailing_postal_code as postal_code,
    mailing_country as country
from {{ ref('stg_location') }}
    where mailing_address_1 is not null