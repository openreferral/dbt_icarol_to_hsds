{%- set tenant_id = var('tenant_id') -%}

select
    {{tenant_id}} as tenant_id,
    cast(agency_num as string) as agency_num,
    code,
    name,
    cast(program_num as string) as program_num
from {{ source('database', 'table_name') }}