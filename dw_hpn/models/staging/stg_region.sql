with source as (
    select * from {{ source('raw', 'RAW_REGION') }}
),

renamed as (
    select
        regionkey::int  as region_key,
        region          as region_name,
        country         as country,
        continent       as continent,
        _loaded_at      as etl_inserted_at,
        _source         as record_source
    from source
)

select * from renamed
