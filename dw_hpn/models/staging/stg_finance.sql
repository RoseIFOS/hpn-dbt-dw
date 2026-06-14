with source as (
    select * from {{ source('raw', 'RAW_FINANCE') }}
),

renamed as (
    select
        finance_key::int                          as finance_key,
        to_date(transaction_date, 'DD/MM/YYYY')   as transaction_date,
        organization_key::int                     as organization_key,
        department_group_key::int                 as department_group_key,
        account_key::int                          as account_key,
        scenario                                  as scenario,
        replace(amount, ',', '.')::number(38,2)   as amount,
        _loaded_at                                as etl_inserted_at,
        _source                                   as record_source
    from source
)

select * from renamed
