--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Create a View for the details for the INSERT:
drop view permissions_meta.group_resources_details_bigquery
go
create view permissions_meta.group_resources_details_bigquery as (
    select distinct 
                    --------------------------------------------------------
                    -- To make up the names
                    grd.g_group_prefix as group_prefix,
                    odtd.o_organisation_identifier as group_identifier,
                    grd.g_group_name as group_name, 
                    case when (grd.g_group_suffix is not null) then
                        concat('-', grd.g_group_suffix)
                    else
                        'default'
                    end as group_suffix, 
                    odtd.o_organisation_email_domain as organisation_email_domain,                                               
                    --------------------------------------------------------
                    -- For the google_bigquery_datasets table:
                    grd.gr_google_cloud_project_id as google_cloud_project_id,
                    grd.gcl_google_cloud_location_id as google_cloud_location_id,
                    grd.g_group_short_description as google_bigquery_dataset_short_description,                        
                    --------------------------------------------------------
                    -- For the group_datasets table:
                    grd.g_group_id,
                    grd.gcr_google_cloud_role_id                                                  
    from permissions_meta.group_resources_denorm grd
        inner join permissions_meta.employee_groups_denorm egd
            on grd.g_group_id = egd.g_group_id
        inner join permissions_meta.organisation_department_team_employees_denorm odted
            on egd.e_employee_id = odted.e_employee_id            
        inner join permissions_meta.organisation_department_teams_denorm odtd
            on odted.odt_organisation_id = odtd.odt_organisation_id
    where grd.gcrt_google_cloud_resource_type_name = 'dataset'
        and grd.gcrt_google_cloud_resource_type_service = 'bigquery'
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
                lower(grdb.group_name), '-',
                grdb.group_suffix
             ) as google_bigquery_dataset_name,
       grdb.google_bigquery_dataset_short_description,              
       0 as google_bigquery_dataset_default_table_expiration, -- TODO: Put a field in the table to specify this
       0 as google_bigquery_dataset_default_partition_expiration -- TODO: Put a field in the table to specify this                           
from permissions_meta.group_resources_details_bigquery grdb



go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- INSERT - into the group datasets table
insert into group_datasets(
    -- group_dataset_id, -- Auto Inc column 
    group_id, 
    google_cloud_role_id, 
    google_bigquery_dataset_id
)
select grdb.g_group_id as group_id,
       grdb.gcr_google_cloud_role_id as google_cloud_role_id,
       gbd.google_bigquery_dataset_id as google_bigquery_dataset_id
from permissions_meta.group_resources_details_bigquery grdb
    inner join permissions_meta.google_bigquery_datasets gbd
        on concat(
                grdb.group_prefix, '-',
                lower(grdb.group_name), '-',
                grdb.group_suffix
             ) = gbd.google_bigquery_dataset_name

















/*
select c.output_dir,
       jdd.google_cloud_project_name,
       jdd.google_big_query_dataset_name,
       concat('{"role": "',
              jdd.google_cloud_role_name,
              '"groupByEmail": "',concat(coalesce(c.prefix_override,''),
                                         c.job_dataset_prefix, '-', 
                                         jdd.organisation_identifier, '-',
                                          lower(replace(jdd.job_name, ' ', '-')),
                                      coalesce(c.suffix_override,''),
                                          '@', jdd.organisation_email_domain_name
                                   ),
       '"}'
       ) permission_line,
       jdd.google_cloud_project_id,
       jdd.google_big_query_dataset_id
from job_datasets_denormalised jdd,
    constants c
    
    
    concat(
                              grd.g_group_prefix, '-',
                              odtd.o_organisation_identifier, '-',
                              lower(grd.g_group_name), 
                              case when (grd.g_group_suffix is not null) then
                                concat('-', grd.g_group_suffix)
                              else
                                '-default'
                              end
                              ) as group_name
                                 
                                 
                                 
select base.group_name as group_name_active_directory,
       concat(base.group_name, '@', base.o_organisation_email_domain) as group_name_iam,
       base.gcp_google_cloud_project_name as resource_google_cloud_project
       
from (                                 
*/