select
    "{{ var('global_source_id') }}" as global_source_id,
    resource_agency_num as id,
    connects_to_site_num,
    connects_to_program_num
from {{ ref('src_resource' ) }}
    where table_name = 'ProgramAtSite'