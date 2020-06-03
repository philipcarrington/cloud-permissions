--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Create a View for the details for the INSERT:
drop view permissions_meta.service_account_resources_details_bigquery
go
create view permissions_meta.service_account_resources_details_bigquery as (
    select distinct
            --------------------------------------------------------
            -- To make up the names:
            'sa' as  service_account_prefix,
            odtgsad.o_organisation_identifier,
            gcsard.gcsa_google_cloud_service_account_name as service_account_name,
            'default' as service_account_suffix,
            odtgsad.o_organisation_email_domain as organisation_email_domain,
            --------------------------------------------------------
            -- For the google_bigquery_datasets table:
            gcsard.gcp_google_cloud_project_id as google_cloud_project_id,
            gcsard.gcl_google_cloud_location_id as google_cloud_location_id,
            concat(
                    'The service account data set of ', gcsard.gcsa_google_cloud_service_account_name            
                   ) as google_bigquery_dataset_short_description,
            --------------------------------------------------------
            -- For the service_account_datasets table:
            odtgsad.odtgsa_google_service_account_id,
            gcsard.gcr_google_cloud_role_id 
from permissions_meta.google_cloud_service_account_resources_denorm gcsard
    inner join permissions_meta.organisation_department_team_google_service_accounts_denorm odtgsad
            on gcsard.gcsar_google_cloud_service_account_id = odtgsad.odtgsa_google_service_account_id
where gcsard.gcrt_google_cloud_resource_type_name = 'dataset'
    and gcsard.gcrt_google_cloud_resource_type_service = 'bigquery'
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
                grdb.service_account_prefix, '-',
                lower(replace(grdb.service_account_name, ' ', '-')), '-',
                grdb.service_account_suffix
             ) as google_bigquery_dataset_name,
       grdb.google_bigquery_dataset_short_description,              
       0 as google_bigquery_dataset_default_table_expiration, -- TODO: Put a field in the table to specify this
       0 as google_bigquery_dataset_default_partition_expiration -- TODO: Put a field in the table to specify this                           
from permissions_meta.service_account_resources_details_bigquery grdb



go

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- INSERT - into the group datasets table
insert into service_account_datasets(
    -- service_account_dataset_id, -- Auto Inc column 
    service_account_id, 
    google_cloud_role_id, 
    google_bigquery_dataset_id
)
select erdb.odtgsa_google_service_account_id as service_account_id,
       erdb.gcr_google_cloud_role_id as google_cloud_role_id,
       gbd.google_bigquery_dataset_id as google_bigquery_dataset_id
from permissions_meta.service_account_resources_details_bigquery erdb
    inner join permissions_meta.google_bigquery_datasets gbd
        on concat(
                erdb.service_account_prefix, '-',
                 lower(replace(erdb.service_account_name, ' ', '-')), '-',
                erdb.service_account_suffix
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
                              grd.g_service_account_prefix, '-',
                              odtd.o_organisation_identifier, '-',
                              lower(grd.g_service_account_name), 
                              case when (grd.g_service_account_suffix is not null) then
                                concat('-', grd.g_service_account_suffix)
                              else
                                '-default'
                              end
                              ) as service_account_name
                                 
                                 
                                 
select base.service_account_name as service_account_name_active_directory,
       concat(base.service_account_name, '@', base.o_organisation_email_domain) as service_account_name_iam,
       base.gcp_google_cloud_project_name as resource_google_cloud_project
       
from (                                 
*/