with stg_program as (
    select
        global_source_id,
        time_created,
        id,
        organization_source_id,
        name,
        alternate_name,
        description,
        email,
        url,
        fees,
        application_process
    from {{ ref('stg_program') }}
),

organization as (
    select
        id,
        source_id
    from {{ ref('organization') }}
)

select
    {{ dbt_utils.surrogate_key([
        'stg_program.global_source_id',
        'stg_program.id',
        'stg_program.name',
        'stg_program.time_created'
    ]) }} as id,
    stg_program.id as source_id,
    stg_program.global_source_id,
    organization.id as organization_id,
    stg_program.name,
    stg_program.alternate_name,
    stg_program.description,
    stg_program.url,
    stg_program.email,
    stg_program.fees,
    stg_program.application_process
from stg_program
join organization
    on stg_program.organization_source_id = organization.source_id
    where organization.id is not null