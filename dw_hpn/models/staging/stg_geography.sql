with source as (
    select * from {{ source('raw', 'RAW_GEOGRAPHY') }}
),

renamed as (
    select
        geographykey::int  as geography_key,
        cityname           as city_name,
        statecode          as state_code,
        statename          as state_name,
        countrycode        as country_code,
        countryname        as country_name,
        regionkey::int     as region_key,
        _loaded_at         as etl_inserted_at,
        _source            as record_source
    from source
)

select * from renamed
