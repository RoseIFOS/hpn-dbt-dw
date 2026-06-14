with source as (
    select * from {{ source('raw', 'RAW_SALES_DETAILS') }}
),

renamed as (
    select
        salesdetailskey::int                            as sales_details_key,
        salesheaderkey::int                             as sales_header_key,
        salesordernumber                                as sales_order_number,
        productkey::int                                 as product_key,
        productsubcategorykey::int                      as product_sub_category_key,
        orderquantity::int                              as order_quantity,
        replace(unitprice, ',', '.')::number(38,4)      as unit_price,
        replace(extendedamount, ',', '.')::number(38,2) as extended_amount,
        _loaded_at                                      as etl_inserted_at,
        _source                                         as record_source
    from source
)

select * from renamed
