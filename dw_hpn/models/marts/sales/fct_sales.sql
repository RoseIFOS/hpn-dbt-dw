-- Fato de vendas no grão de linha de pedido.
-- Traz o custo unitário via lookup (produto + país do cliente + ano/mês do pedido)
-- e pré-calcula as medidas linha-a-linha (gross, desconto, custo, net, margem).

with lines as (
    select * from {{ ref('int_sales_lines') }}
),

customer as (
    select customer_key, country_code from {{ ref('dim_customer') }}
),

cost_history as (
    select * from {{ ref('stg_product_cost_history') }}
),

joined as (
    select
        l.sales_details_key,
        l.sales_header_key,
        l.sales_order_number,
        l.product_key,
        l.customer_key,
        l.region_key,
        l.order_date,
        l.due_date,
        l.ship_date,
        l.order_quantity,
        l.unit_price,
        l.extended_amount,
        l.discount_amount,
        ch.unit_cost
    from lines l
    left join customer cu
        on l.customer_key = cu.customer_key
    left join cost_history ch
        on  ch.product_key  = l.product_key
        and ch.country_code = cu.country_code
        and ch.cost_year    = year(l.order_date)
        and ch.cost_month   = month(l.order_date)
)

select
    sales_details_key,
    sales_header_key,
    sales_order_number,
    product_key,
    customer_key,
    region_key,
    order_date,
    due_date,
    ship_date,
    order_quantity,
    unit_price,
    unit_cost,

    -- medidas linha-a-linha (Gross = qty * price = extended_amount)
    extended_amount                                                   as gross_amount,
    discount_amount,
    order_quantity * unit_cost                                        as cost_amount,
    extended_amount - discount_amount                                 as net_amount,
    (extended_amount - discount_amount) - (order_quantity * unit_cost) as gross_margin_amount

from joined
