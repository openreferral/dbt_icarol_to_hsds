/*
    Phone numbers exist for three core tables, so I'm staging them here to keep
    things DRY.

    This uses fax for service and service_at_location.
*/
with p as (
        select
            tenant_id,
            {{ dbt_utils.surrogate_key([
                'tenant_id',
                'source_id',
                '"phone_fax"'
            ]) }} as id,
            id as link_id,
            source_id,
            phone_fax as number,
            phone_fax_description as description,
            'fax' as type,
            table_name
        from {{ ref('src_resource' ) }}
            where phone_fax_is_private is false
            and phone_fax is not null
),

s as (
    select
        tenant_id,
        id,
        link_id as service_id,
        source_id as source_service_id,
        cast(null as string) as service_at_location_id,
        cast(null as string) as source_service_at_location_id,
        number,
        description,
        type
    from p
        where table_name = 'Program'
),

sal as (
    select distinct
        p.tenant_id,
        p.id,
        cast(null as string) as service_id,
        cast(null as string) as source_service_id,
        link_id as service_at_location_id,
        source_id as source_service_at_location_id,
        number,
        description,
        type
    from {{ ref('stg_service_at_location') }} sal
    join p on sal.location_id = p.link_id
)

select * from s
union all
select * from sal