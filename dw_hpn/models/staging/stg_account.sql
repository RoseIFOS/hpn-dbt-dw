with source as (
    select * from {{ source('raw', 'RAW_ACCOUNT') }}
),

renamed as (
    select
        accountkey::int           as account_key,
        accountheaderkey::int     as account_header_key,
        accountsubheaderkey::int  as account_sub_header_key,
        account                   as account_name,
        accounttype               as account_type,
        sign::int                 as sign,
        accountsubheader          as account_sub_header,
        subheaderdetail::int      as sub_header_detail,
        _loaded_at                as etl_inserted_at,
        _source                   as record_source
    from source
)

select * from renamed
