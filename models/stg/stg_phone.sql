/*
    Phone numbers exist for three core tables, so I'm staging them here to keep
    things DRY.

    This uses phone for service and service_at_location.
*/
with p as (
        select
            tenant_id,
            {{ dbt_utils.surrogate_key([
                'tenant_id',
                'source_id',
                '"phone_1_number"'
            ]) }} as id,
            id as link_id,
            source_id,
            phone_1_number as number,
            -- Phone has two potential description fields
            coalesce(
                concat(phone_1_name, '. ', phone_1_description),
                phone_1_name,
                ''
            ) as description,
            'voice' as type,
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
        number,
        description,
        type
    from p
        where table_name = 'Program'
),

sal as (
    select
        p.tenant_id,
        p.id,
        cast(null as string) as service_id,
        cast(null as string) as source_service_id,
        sal.id as service_at_location_id,
        sal.source_service_at_location_id,
        number,
        description,
        type
    from {{ ref('stg_service_at_location') }} sal
    join p on sal.location_id = p.link_id
)

select * from s
union all
select * from sal