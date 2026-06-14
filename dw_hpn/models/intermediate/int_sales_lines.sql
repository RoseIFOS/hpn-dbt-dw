-- Junta os itens (sales_details) com o cabeçalho (sales_header) para trazer
-- datas, cliente e região para o grão de linha de pedido.
-- Aloca o desconto do header proporcionalmente em cada linha pelo extended_amount.

with details as (
    select * from {{ ref('stg_sales_details') }}
),

header as (
    select * from {{ ref('stg_sales_header') }}
)

select
    d.sales_details_key,
    d.sales_header_key,
    d.sales_order_number,
    d.product_key,
    d.product_sub_category_key,
    d.order_quantity,
    d.unit_price,
    d.extended_amount,

    -- atributos vindos do cabeçalho
    h.order_date,
    h.due_date,
    h.ship_date,
    h.customer_key,
    h.region_key,

    -- alocação proporcional do desconto do pedido para a linha:
    -- desconto_linha = extended_amount * (desconto_header / total_header)
    round(d.extended_amount * div0(h.discount_amount, h.total_amount), 2) as discount_amount

from details d
left join header h
    on d.sales_header_key = h.sales_header_key
