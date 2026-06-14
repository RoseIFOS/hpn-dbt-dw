-- Dimensão conformada de cliente: junta cliente + geografia + região
-- (segue o modelo do Power BI, onde a região é atributo do cliente).

with customer as (
    select * from {{ ref('stg_customer') }}
),

geography as (
    select * from {{ ref('stg_geography') }}
),

region as (
    select * from {{ ref('stg_region') }}
)

select
    c.customer_key,
    c.customer_name,
    c.business_type,
    c.number_employees,
    c.annual_revenue,
    c.year_opened,

    -- geografia
    c.geography_key,
    g.city_name,
    g.state_code,
    g.state_name,
    g.country_code,
    g.country_name,

    -- região
    g.region_key,
    r.region_name,
    r.country       as region_country,
    r.continent

from customer c
left join geography g on c.geography_key = g.geography_key
left join region r    on g.region_key = r.region_key
