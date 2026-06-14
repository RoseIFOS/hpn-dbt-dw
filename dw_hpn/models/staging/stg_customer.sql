with source as (
    select * from {{ source('raw', 'RAW_CUSTOMER') }}
),

renamed as (
    select
        customerkey::int             as customer_key,
        geographykey::int            as geography_key,
        customer                     as customer_name,
        businesstype                 as business_type,
        numberemployees::int         as number_employees,
        annualrevenue::number(38,0)  as annual_revenue,
        yearopened::int              as year_opened,
        _loaded_at                   as etl_inserted_at,
        _source                      as record_source
    from source
)

select * from renamed
