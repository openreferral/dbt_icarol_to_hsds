select
    tenant_id,
    {{ dbt_utils.surrogate_key([
        'tenant_id',
        'code'
    ]) }} as id,
    program_num as source_service_id,
    code as term,
    name as description,
    -- This is hardcoded for 211 Taxonomy. Custom taxonomies will need to be
    -- unioned with this table.
    '211 Taxonomy' as taxonomy
from {{ ref('src_taxonomy' ) }}