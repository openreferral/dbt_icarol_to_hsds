{%- set tenant_id = var('tenant_id') -%}

select
    {{tenant_id}} as tenant_id,
    city,
    country,
    county,
    cast(resource_id as string) as resource_id,
    resource_name,
    state_province,
    zip_postal_code
from {{ source('database', 'table_name') }}