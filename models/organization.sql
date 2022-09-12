select
    {{ dbt_utils.surrogate_key([
        'global_source_id',
        'id',
        'name',
        'time_created'
    ]) }} as id,
    id as source_id,
    global_source_id,
    name,
    description,
    email
    url,
    legal_status
from {{ ref('stg_agency') }}