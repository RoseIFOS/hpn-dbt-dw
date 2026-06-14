-- Dimensão conformada de produto: junta produto + subcategoria + categoria.

with product as (
    select * from {{ ref('stg_product') }}
),

sub_category as (
    select * from {{ ref('stg_product_sub_category') }}
)

select
    p.product_key,
    p.product_name,
    p.product_size,
    p.product_detail,
    p.product_sub_category_key,
    s.sub_category_name,
    s.category_name

from product p
left join sub_category s
    on p.product_sub_category_key = s.product_sub_category_key
