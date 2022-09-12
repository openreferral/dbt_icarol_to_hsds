with stg_site as (
    select
        global_source_id,
        time_created,
        id,
        mailing_address_1 as address_1,
        mailing_city as city,
        mailing_state_province as state_province,
        mailing_postal_code as postal_code,
        mailing_country as country
    from {{ ref('stg_site') }}
),

location as (
    select
        id,
        source_id
    from {{ ref('location') }}
)

select
    {{ dbt_utils.surrogate_key([
        'stg_site.global_source_id',
        'location.id',
        'location.source_id',
        'stg_site.time_created'
    ]) }} as id,
    global_source_id,
    location.id as location_id,
    location.source_id as location_source_id,
    stg_site.address_1,
    stg_site.city,
    stg_site.state_province,
    stg_site.postal_code,
    stg_site.country
from stg_site
join location
    on location.source_id = stg_site.id