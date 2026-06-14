-- Dimensão de grupo de departamento (exclusiva do domínio financeiro).

select
    department_group_key,
    department_group_name

from {{ ref('stg_department_group') }}
