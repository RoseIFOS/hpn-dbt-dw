with source as (
    select * from {{ source('raw', 'RAW_PRODUCT') }}
),

renamed as (
    select
        productkey::int             as product_key,
        productsubcategorykey::int  as product_sub_category_key,
        productname                 as product_name,
        size                        as product_size,
        detail                      as product_detail,
        _loaded_at                  as etl_inserted_at,
        _source                     as record_source
    from source
)

select * from renamed
