select
    agency_num,
    code,
    name,
    program_num
from {{ source('database', 'table_name') }}