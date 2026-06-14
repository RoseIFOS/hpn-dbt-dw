-- Fato financeiro (DRE). Pré-calcula o valor com sinal contábil
-- (amount * sign), que simplifica a medida "Total Amount" no Power BI.

with finance as (
    select * from {{ ref('stg_finance') }}
),

account as (
    select account_key, sign from {{ ref('stg_account') }}
)

select
    f.finance_key,
    f.transaction_date,
    f.organization_key,
    f.department_group_key,
    f.account_key,
    f.scenario,
    f.amount,
    a.sign,
    f.amount * a.sign as signed_amount

from finance f
left join account a
    on f.account_key = a.account_key
