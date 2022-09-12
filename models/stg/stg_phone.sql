/*
    Phone numbers exist for three core tables, so I'm staging them here to keep
    things DRY.

    We are only displaying numbers for services and locations at this time.

    This project is only pulling the main phone number. However,
*/
select
    "{{ var('global_source_id') }}" as global_source_id,
    time_created,
    resource_agency_num as id,
    phone_1_number as phone_number,
    coalesce(
        concat(phone_1_name, '. ', phone_1_description),
        phone_1_name,
        ''
    ) as phone_description,
    'voice' as type,
    phone_1_is_private
from {{ ref('src_resource' ) }}
where phone_1_is_private is false
and phone_1_number is not null
and (
    table_name = 'Program' or
    table_name = 'Site'
)