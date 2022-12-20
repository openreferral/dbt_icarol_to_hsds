/*
    Hours exist for three core tables, so I'm staging them here to keep
    things DRY.

    This uses schedule for service and service_at_location.
*/
with h as (
    select
        tenant_id,
        {{ dbt_utils.surrogate_key([
            'tenant_id',
            'source_id',
            '"hours_of_operation"',
            '"hours"'
        ]) }} as id,
        id as link_id,
        source_id,
        -- Fallthrough from free-text schedule to structured schedule.
        -- TODO: This be changed for apps that handle structured time data.
        coalesce(
            hours_of_operation,
            hours
        ) as description,
        table_name
    from {{ ref('src_resource' ) }}
        where phone_1_is_private is false
        and phone_1_number is not null
),

s as (
    select
        tenant_id,
        id,
        link_id as service_id,
        source_id as source_service_id,
        cast(null as string) as service_at_location_id,
        cast(null as string) as source_service_at_location_id,
        description
    from h
        where table_name = 'Program'
),

sal as (
    select distinct
        h.tenant_id,
        h.id,
        cast(null as string) as service_id,
        cast(null as string) as source_service_id,
        sal.id as service_at_location_id,
        sal.source_service_at_location_id,
        description
    from {{ ref('stg_service_at_location') }} sal
    join h on sal.location_id = h.link_id
)

select * from s
union all
select * from sal