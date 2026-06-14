with source as (
    select * from {{ source('raw', 'RAW_PRODUCT_COST_HISTORY') }}
),

renamed as (
    select
        productkey::int                           as product_key,
        countrycode                               as country_code,
        year::int                                 as cost_year,
        monthno::int                              as cost_month,
        replace(unitcost, ',', '.')::number(38,4) as unit_cost,
        _loaded_at                                as etl_inserted_at,
        _source                                   as record_source
    from source
)

select * from renamed
