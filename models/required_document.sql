with stg_program as (
    select
        global_source_id,
        time_created,
        id,
        document
    from {{ ref('stg_program') }}
    where document is not null
    and document <> ''
),

service as (
    select
        id,
        source_id
    from {{ ref('service') }}
)

select
    {{ dbt_utils.surrogate_key([
        'stg_program.global_source_id',
        'stg_program.id',
        'stg_program.document',
        'stg_program.time_created'
    ]) }} as id,
    stg_program.global_source_id,
    service.id as service_id,
    service.source_id as service_source_id,
    stg_program.document
from stg_program
join service
    on service.source_id = stg_program.id