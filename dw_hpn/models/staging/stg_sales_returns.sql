with source as (
    select * from {{ source('raw', 'RAW_SALES_RETURNS') }}
),

renamed as (
    select
        returnkey::int                               as return_key,
        to_date(returndate, 'DD/MM/YYYY')            as return_date,
        to_date(orderdate, 'DD/MM/YYYY')             as order_date,
        salesordernumber                             as sales_order_number,
        customerkey::int                             as customer_key,
        productkey::int                              as product_key,
        returnquantity::int                          as return_quantity,
        replace(unitprice, ',', '.')::number(38,4)   as unit_price,
        replace(returnamount, ',', '.')::number(38,2) as return_amount,
        _loaded_at                                   as etl_inserted_at,
        _source                                      as record_source
    from source
)

select * from renamed
