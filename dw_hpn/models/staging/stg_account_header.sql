with source as (
    select * from {{ source('raw', 'RAW_ACCOUNT_HEADER') }}
),

renamed as (
    select
        accountheaderkey::int  as account_header_key,
        accountheader          as account_header_name,
        detail::int            as detail,
        _loaded_at             as etl_inserted_at,
        _source                as record_source
    from source
)

select * from renamed
