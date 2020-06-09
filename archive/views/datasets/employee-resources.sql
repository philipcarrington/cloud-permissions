--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Create a View for the details for the INSERT:
drop view permissions_meta.employee_resources_details_bigquery
go
create view permissions_meta.employee_resources_details_bigquery as (
    select distinct
                --------------------------------------------------------
                -- To make up the names:
                'emp' as  employee_prefix,
                odted.o_organisation_identifier,
                concat(erd.e_given_name, '_', erd.e_family_name) as employee_name,
                'default' as employee_suffix,
                odted.o_organisation_email_domain as organisation_email_domain,
                --------------------------------------------------------
                -- For the google_bigquery_datasets table:
                erd.er_google_cloud_project_id as google_cloud_project_id,
                erd.gcl_google_cloud_location_id as google_cloud_location_id,
                concat(
                        'The personal data set of ', erd.e_given_name, ' ', erd.e_family_name, '\n',
                        'in the ', odted.t_team_name, ' part of the ', odted.d_department_name                     
                       ) as google_bigquery_dataset_short_description,
                --------------------------------------------------------
                -- For the employee_datasets table:
                erd.e_employee_id,
                erd.gcr_google_cloud_role_id 
from permissions_meta.employee_resources_denorm erd
    inner join permissions_meta.organisation_department_team_employees_denorm odted
            on erd.e_employee_id = odted.e_employee_id
where erd.gcrt_google_cloud_resource_type_name = 'dataset'
    and erd.gcrt_google_cloud_resource_type_service = 'bigquery'
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
                grdb.employee_prefix, '-',
                lower(grdb.employee_name), '-',
                grdb.employee_suffix
             ) as google_bigquery_dataset_name,
       grdb.google_bigquery_dataset_short_description,              
       0 as google_bigquery_dataset_default_table_expiration, -- TODO: Put a field in the table to specify this
       0 as google_bigquery_dataset_default_partition_expiration -- TODO: Put a field in the table to specify this                           
from permissions_meta.employee_resources_details_bigquery grdb



go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- INSERT - into the group datasets table
insert into employee_datasets(
    -- employee_dataset_id, -- Auto Inc column 
    employee_id, 
    google_cloud_role_id, 
    google_bigquery_dataset_id
)
select erdb.e_employee_id as employee_id,
       erdb.gcr_google_cloud_role_id as google_cloud_role_id,
       gbd.google_bigquery_dataset_id as google_bigquery_dataset_id
from permissions_meta.employee_resources_details_bigquery erdb
    inner join permissions_meta.google_bigquery_datasets gbd
        on concat(
                erdb.employee_prefix, '-',
                lower(erdb.employee_name), '-',
                erdb.employee_suffix
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
                              grd.g_employee_prefix, '-',
                              odtd.o_organisation_identifier, '-',
                              lower(grd.g_employee_name), 
                              case when (grd.g_employee_suffix is not null) then
                                concat('-', grd.g_employee_suffix)
                              else
                                '-default'
                              end
                              ) as employee_name
                                 
                                 
                                 
select base.employee_name as employee_name_active_directory,
       concat(base.employee_name, '@', base.o_organisation_email_domain) as employee_name_iam,
       base.gcp_google_cloud_project_name as resource_google_cloud_project
       
from (                                 
*/