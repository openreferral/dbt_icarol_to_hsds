/*
    Hours exist for three core tables, so I'm staging them here to keep
    things DRY.

    We are only displaying numbers for services and locations at this time.
*/
select
    "{{ var('global_source_id') }}" as global_source_id,
    time_created,
    resource_agency_num as id,
    -- Fallthrough from free-text schedule to structured schedule.
    -- We aren't ready to handle structured as the primary yet.
    coalesce(
        hours_of_operation,
        hours,
        ''
    ) as description
from {{ ref('src_resource' ) }}
where table_name = 'Program'
or table_name = 'Site'