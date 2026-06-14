with source as (
    select * from {{ source('raw', 'RAW_PRODUCT_SUB_CATEGORY') }}
),

renamed as (
    select
        productsubcategorykey::int  as product_sub_category_key,
        subcategoryname             as sub_category_name,
        categoryname                as category_name,
        _loaded_at                  as etl_inserted_at,
        _source                     as record_source
    from source
)

select * from renamed
