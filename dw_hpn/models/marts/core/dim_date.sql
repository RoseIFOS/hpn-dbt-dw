{#-
  ============================================================================
  dim_date — dimensão de calendário com range DINÂMICO
  ============================================================================
  início = 1º de janeiro do MENOR ano encontrado nas vendas (header + devoluções)
  fim    = 31 de dezembro do ANO CORRENTE

  Conceitos usados aqui:

  - run_query: executa SQL no Snowflake DURANTE a compilação do modelo e
    devolve o resultado pro Jinja. É assim que pegamos o menor ano direto dos
    dados, em vez de cravar um valor fixo.

  - Início = menor ano das vendas: unimos stg_sales_header + stg_sales_returns
    (igual o Power BI fazia, que pegava o min de fSalesDetails e fSalesReturns)
    e tiramos min(year(order_date)). Ex.: vira "2023-01-01".

  - Fim = 31/12 do ano corrente: modules.datetime.datetime.now().year ~ "-12-31"
    => ex. "2026-12-31". Não usa a data máxima dos dados; usa o ano atual.

  - Guard {% if execute %}: no `dbt parse` o execute é false e o banco nem é
    consultado — por isso o fallback 2020. Sem o guard, o parse quebraria ao
    tentar rodar a query. No `dbt run`/`build` o execute é true e busca o ano real.

  - Dependência no DAG: como usamos ref('stg_sales_header') e
    ref('stg_sales_returns'), o dbt garante que o staging é construído ANTES do
    dim_date, então a query do run_query sempre acha as tabelas.
    Trade-off: o dim_date passa a depender das tabelas de vendas (o range do
    calendário "segue" os dados). Para desacoplar, basta voltar a datas fixas.
  ============================================================================
-#}

{%- set bounds_query -%}
    select min(year(order_date)) as min_year
    from (
        select order_date from {{ ref('stg_sales_header') }}
        union all
        select order_date from {{ ref('stg_sales_returns') }}
    )
{%- endset -%}

{%- if execute -%}
    {%- set min_year = run_query(bounds_query).rows[0][0] | int -%}
{%- else -%}
    {#- durante o parse (execute=false) usamos um fallback só para compilar -#}
    {%- set min_year = 2020 -%}
{%- endif -%}

{%- set start_date = min_year ~ "-01-01" -%}
{%- set end_date = modules.datetime.datetime.now().year ~ "-12-31" -%}

{{ dbt_date.get_date_dimension(start_date, end_date) }}
