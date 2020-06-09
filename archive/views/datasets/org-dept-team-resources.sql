--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Create a View for the details for the INSERT:
drop view permissions_meta.organisation_department_team_resources_details_bigquery
go
create view permissions_meta.organisation_department_team_resources_details_bigquery as (
    select distinct 
                    --------------------------------------------------------
                    -- To make up the names
                    'team' as group_prefix,
                    odtd.o_organisation_identifier as group_identifier,
                    odtd.d_department_name,                 
                    case when (odtd.t_team_name is not null) then
                         odtd.t_team_name
                    else
                        'default'
                    end as group_suffix, 
                    odtd.o_organisation_email_domain as organisation_email_domain,
                    --------------------------------------------------------
                    -- For the google_bigquery_datasets table:
                    odtrd.gcp_google_cloud_project_id as google_cloud_project_id,
                    odtrd.gcl_google_cloud_location_id as google_cloud_location_id,
                    '' as google_bigquery_dataset_short_description,
                    --------------------------------------------------------
                    -- For the group_datasets table:
                    odtd.odt_organisation_department_team_id,
                    odtrd.gcr_google_cloud_role_id
    from permissions_meta.organisation_department_team_resources_denorm odtrd
         inner join permissions_meta.organisation_department_team_employees_denorm odted
                on odtrd.odtr_organisation_department_team_id = odted.odt_organisation_department_team_id
         inner join permissions_meta.organisation_department_teams_denorm odtd
                on odted.odt_organisation_id = odtd.odt_organisation_id
    where odtrd.gcrt_google_cloud_resource_type_name = 'dataset'
        and odtrd.gcrt_google_cloud_resource_type_service = 'bigquery'
)                                
go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- INSERT - into the google bigquery datasets table first:

insert into google_bigquery_datasets(
    -- google_bigquery_dataset_id, -- Auto ID
	google_cloud_project_id,
	google_cloud_location_id,
	google_bigquery_dataset_name,
	google_bigquery_dataset_short_description,
	google_bigquery_dataset_default_table_expiration,
	google_bigquery_dataset_default_partition_expiration
)
select grdb.google_cloud_project_id,
       grdb.google_cloud_location_id,
       concat(
                grdb.group_prefix, '-',
                lower(grdb.d_department_name), '-',
                replace(lower(grdb.group_suffix), ' ','')
             ) as google_bigquery_dataset_name,
       grdb.google_bigquery_dataset_short_description,              
       0 as google_bigquery_dataset_default_table_expiration, -- TODO: Put a field in the table to specify this
       0 as google_bigquery_dataset_default_partition_expiration -- TODO: Put a field in the table to specify this                           
from permissions_meta.organisation_department_team_resources_details_bigquery grdb
go
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- INSERT - into the organisation_department_team_datasets table

INSERT INTO organisation_department_team_datasets(
    -- organisation_department_team_dataset_id, 
    organisation_department_team_id, 
    google_cloud_role_id, 
    google_bigquery_dataset_id
) 
select distinct odtdb.odt_organisation_department_team_id as organisation_department_team_id,
               odtdb.gcr_google_cloud_role_id as google_cloud_role_id,
               gbd.google_bigquery_dataset_id as google_bigquery_dataset_id
from permissions_meta.organisation_department_team_resources_details_bigquery odtdb
    inner join permissions_meta.google_bigquery_datasets gbd
        on concat(
                odtdb.group_prefix, '-',
                lower(odtdb.d_department_name), '-',
                replace(lower(odtdb.group_suffix), ' ','')
             ) = gbd.google_bigquery_dataset_name
go