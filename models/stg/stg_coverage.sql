select
    "{{ var('global_source_id') }}" as global_source_id,
    resource_id as program_id,
    city,
    country,
    county,
    state_province,
    zip_postal_code as postal_code
from {{ ref('src_coverage' )}}