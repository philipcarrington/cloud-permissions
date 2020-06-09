--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Create a View for the details for the INSERT:
drop view permissions_meta.job_resources_details_bigquery
go
create view permissions_meta.job_resources_details_bigquery as (
    select distinct
                --------------------------------------------------------
                -- To make up the names
                'job' as group_prefix,
                odtd.o_organisation_identifier as group_identifier,
                jrn.j_job_name as group_name,                 
                'default' as group_suffix, 
                odtd.o_organisation_email_domain as organisation_email_domain,
                --------------------------------------------------------
                -- For the google_bigquery_datasets table:
                jrn.gcp_google_cloud_project_id as google_cloud_project_id,
                jrn.gcl_google_cloud_location_id as google_cloud_location_id,
                '' as google_bigquery_dataset_short_description,
                --------------------------------------------------------
                -- For the group_datasets table:
                jrn.j_job_id,
                jrn.jr_google_cloud_role_id
from permissions_meta.job_resources_denorm jrn
    inner join permissions_meta.employee_jobs_denorm ejd
        on jrn.j_job_id = ejd.j_job_id
    inner join permissions_meta.organisation_department_team_employees_denorm odted
            on ejd.e_employee_id = odted.e_employee_id
    inner join permissions_meta.organisation_department_teams_denorm odtd
            on odted.odt_organisation_id = odtd.odt_organisation_id
    where jrn.gcrt_google_cloud_resource_type_name = 'dataset'
        and jrn.gcrt_google_cloud_resource_type_service = 'bigquery'
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
                replace(lower(grdb.group_name), ' ',''), '-',
                replace(lower(grdb.group_suffix), ' ','')
             ) as google_bigquery_dataset_name,
       grdb.google_bigquery_dataset_short_description,              
       0 as google_bigquery_dataset_default_table_expiration, -- TODO: Put a field in the table to specify this
       0 as google_bigquery_dataset_default_partition_expiration -- TODO: Put a field in the table to specify this                           
from permissions_meta.job_resources_details_bigquery grdb
go
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- INSERT - into the job_datasets tables table

INSERT INTO job_datasets(
    -- job_dataset_id, 
    job_id, 
    google_cloud_role_id, 
    google_bigquery_dataset_id
) 
select jrdb.j_job_id,
       jrdb.jr_google_cloud_role_id,
       gbd.google_bigquery_dataset_id
from permissions_meta.job_resources_details_bigquery jrdb
    inner join permissions_meta.google_bigquery_datasets gbd
        on concat(
                jrdb.group_prefix, '-',
                replace(lower(jrdb.group_name), ' ',''), '-',
                replace(lower(jrdb.group_suffix), ' ','')
             ) = gbd.google_bigquery_dataset_name
go             