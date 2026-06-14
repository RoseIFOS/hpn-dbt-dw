-- Dimensão de conta contábil (exclusiva do domínio financeiro).

select
    account_key,
    account_header_key,
    account_sub_header_key,
    account_name,
    account_type,
    sign,
    account_sub_header,
    sub_header_detail

from {{ ref('stg_account') }}
