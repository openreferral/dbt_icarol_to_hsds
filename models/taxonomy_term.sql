select distinct
    {{ dbt_utils.surrogate_key([
        'global_source_id',
        'term',
        'description'
    ]) }} as id,
    global_source_id,
    term,
    description,
    '211 Taxonomy' as taxonomy
from {{ ref('stg_taxonomy') }}