-- Fato de devoluções de venda. Grão: uma linha por devolução.
-- return_amount já vem como return_quantity * unit_price (validado na origem).

select
    return_key,
    sales_order_number,
    customer_key,
    product_key,
    return_date,
    order_date,
    return_quantity,
    unit_price,
    return_amount

from {{ ref('stg_sales_returns') }}
