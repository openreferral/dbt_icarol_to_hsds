select
    city,
    country,
    county,
    resource_id,
    resource_name,
    state_province,
    zip_postal_code
from {{ source('database', 'table_name') }}