with stg_site as (
    select
        global_source_id,
        time_created,
        id,
        organization_source_id,
        name,
        alternate_name,
        description,
        latitude,
        longitude
    from {{ ref('stg_site') }}
),

organization as (
    select
        id,
        source_id
    from {{ ref('organization') }}
)

select
    {{ dbt_utils.surrogate_key([
        'stg_site.global_source_id',
        'stg_site.id',
        'stg_site.name',
        'stg_site.time_created'
    ]) }} as id,
    stg_site.id as source_id,
    stg_site.global_source_id,
    organization.id as organization_id,
    stg_site.name,
    stg_site.alternate_name,
    stg_site.description,
    stg_site.latitude,
    stg_site.longitude
from stg_site
join organization
    on stg_site.organization_source_id = organization.source_id
    where organization.id is not null