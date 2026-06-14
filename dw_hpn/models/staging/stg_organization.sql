with source as (
    select * from {{ source('raw', 'RAW_ORGANIZATION') }}
),

renamed as (
    select
        organizationkey::int  as organization_key,
        organization          as organization_name,
        parentorganization    as parent_organization_name,
        _loaded_at            as etl_inserted_at,
        _source               as record_source
    from source
)

select * from renamed
