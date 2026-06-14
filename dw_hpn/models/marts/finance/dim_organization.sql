-- Dimensão de organização (exclusiva do domínio financeiro).

select
    organization_key,
    organization_name,
    parent_organization_name

from {{ ref('stg_organization') }}
