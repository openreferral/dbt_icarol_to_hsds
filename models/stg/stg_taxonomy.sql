select
    "{{ var('global_source_id') }}" as global_source_id,
    program_num as program_id,
    code as term,
    name as description
from {{ ref('src_taxonomy' ) }}