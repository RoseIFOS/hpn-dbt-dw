-- Dimensão de cabeçalho de conta (exclusiva do domínio financeiro).

select
    account_header_key,
    account_header_name,
    detail

from {{ ref('stg_account_header') }}
