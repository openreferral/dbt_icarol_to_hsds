/*
    fax numbers exist for three core tables, so i'm staging them here to keep
    things DRY.

    we are only displaying numbers for services and locations at this time.

    TODO: add phone numbers for agencies after the app can use them.
*/
select
    "{{ var('global_source_id') }}" as global_source_id,
    time_created,
    resource_agency_num as id,
    phone_fax as phone_number,
    phone_fax_description as phone_description,
    'fax' as type,
    phone_fax_is_private
from {{ ref('src_resource' ) }}
where phone_fax_is_private is false
and phone_fax is not null
and (
    table_name = 'Program' or
    table_name = 'Site'
)