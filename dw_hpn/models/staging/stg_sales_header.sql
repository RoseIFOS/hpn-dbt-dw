with source as (
    select * from {{ source('raw', 'RAW_SALES_HEADER') }}
),

renamed as (
    select
        salesheaderkey::int                            as sales_header_key,
        salesordernumber                               as sales_order_number,
        to_date(orderdate, 'DD/MM/YYYY')               as order_date,
        to_date(duedate, 'DD/MM/YYYY')                 as due_date,
        to_date(shipdate, 'DD/MM/YYYY')                as ship_date,
        customerkey::int                               as customer_key,
        regionkey::int                                 as region_key,
        replace(discountamount, ',', '.')::number(38,2) as discount_amount,
        replace(totalamount, ',', '.')::number(38,2)    as total_amount,
        replace(salesamount, ',', '.')::number(38,2)    as sales_amount,
        _loaded_at                                     as etl_inserted_at,
        _source                                        as record_source
    from source
)

select * from renamed
