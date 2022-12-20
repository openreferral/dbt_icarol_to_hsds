-- Combine the service and location tables.
select * from {{ ref('stg_phone') }}
union all
select * from {{ ref('stg_fax') }}