with source as (
    select * from {{ source('raw', 'RAW_DEPARTMENT_GROUP') }}
),

renamed as (
    select
        departmentgroupkey::int  as department_group_key,
        departmentgroupname      as department_group_name,
        _loaded_at               as etl_inserted_at,
        _source                  as record_source
    from source
)

select * from renamed
