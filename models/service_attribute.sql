with stg_taxonomy as (
    select
        global_source_id,
        program_id,
        term,
        description
    from {{ ref('stg_taxonomy') }}
),

taxonomy_term as (
    select
        id,
        term
    from {{ ref('taxonomy_term') }}
),

service as (
    select
        id,
        source_id
    from {{ ref('service') }}
)

select
    {{ dbt_utils.surrogate_key([
        'stg_taxonomy.global_source_id',
        'stg_taxonomy.term',
        'stg_taxonomy.description',
        'stg_taxonomy.program_id'
    ]) }} as id,
    global_source_id,
    stg_taxonomy.program_id,
    service.id as service_id,
    service.source_id as service_source_id,
    taxonomy_term.id as taxonomy_term_id
from stg_taxonomy
join taxonomy_term on stg_taxonomy.term = taxonomy_term.term
join service on stg_taxonomy.program_id = service.source_id