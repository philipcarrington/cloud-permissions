with 
    constants as (
        select '/tmp/' as permissions_file_output_dir
    ),
    dataset_data_base as (
        /*
            Organistaion Department Team:
        */        
        select 
               -- Identifiers:
               odtdd.gbd_google_cloud_project_id as internal_google_cloud_project_id,
               odtdd.gcp_google_cloud_project_name as google_cloud_project_name,
               odtdd.gbd_google_bigquery_dataset_id as internal_google_bigquery_dataset_id,
               odtdd.gbd_google_bigquery_dataset_name as google_bigquery_dataset_name,
               -- Dataset Detail:
               odtdd.gcl_google_cloud_location_name as google_cloud_location_name,
               odtdd.gbd_google_bigquery_dataset_default_table_expiration as google_bigquery_dataset_default_table_expiration,
               odtdd.gbd_google_bigquery_dataset_default_partition_expiration as google_bigquery_dataset_default_partition_expiration,
               odtdd.gbd_google_bigquery_dataset_short_description as google_bigquery_dataset_short_description,
               -- Permissions Details:
               odtdd.gcr_google_cloud_role_role as role_type,
               '"groupByEmail"' as permission_type,
               'team' as dataset_prefix,
               odtdd.o_organisation_identifier as organisation_identifier,
               odtdd.d_department_name as dataset_name_pt1,
               odtdd.t_team_name as dataset_name_pt2,
               null as permissions_email_override,               
               odtdd.o_organisation_email_domain as organisation_email_domain
        from permissions_meta.organisation_department_team_datasets_denorm odtdd
        union
        /*
            Groups:
        */
        select distinct  
               -- Identifiers:
               gdd.gbd_google_cloud_project_id as internal_google_cloud_project_id,
               gdd.gcp_google_cloud_project_name as google_cloud_project_name,
               gdd.gbd_google_bigquery_dataset_id as internal_google_bigquery_dataset_id,
               gdd.gbd_google_bigquery_dataset_name as google_bigquery_dataset_name,
               -- Dataset Detail:
               gdd.gcl_google_cloud_location_name as google_cloud_location_name,
               gdd.gbd_google_bigquery_dataset_default_table_expiration as google_bigquery_dataset_default_table_expiration,
               gdd.gbd_google_bigquery_dataset_default_partition_expiration as google_bigquery_dataset_default_partition_expiration,
               gdd.gbd_google_bigquery_dataset_short_description as google_bigquery_dataset_short_description,
               -- Permissions Details:
               gdd.gcr_google_cloud_role_role as role_type,
               '"groupByEmail"' as permission_type,
               gdd.g_group_prefix as dataset_prefix,
               odted.o_organisation_identifier as organisation_identifier,
               gdd.g_group_name as dataset_name_pt1,
               null as dataset_name_pt2,
               null as permissions_email_override,              
               odted.o_organisation_email_domain as organisation_email_domain
        from permissions_meta.group_datasets_denorm gdd
             inner join permissions_meta.employee_groups eg 
                on gdd.g_group_id = eg.group_id
            inner join permissions_meta.organisation_department_team_employees_denorm odted
                on eg.employee_id = odted.e_employee_id
        union
        /*
            Jobs:
        */
        select distinct
               -- Identifiers:
               jdd.gbd_google_cloud_project_id as internal_google_cloud_project_id,
               jdd.gcp_google_cloud_project_name as google_cloud_project_name,
               jdd.gbd_google_bigquery_dataset_id as internal_google_bigquery_dataset_id,
               jdd.gbd_google_bigquery_dataset_name as google_bigquery_dataset_name,
               -- Dataset Detail:
               jdd.gcl_google_cloud_location_name as google_cloud_location_name,
               jdd.gbd_google_bigquery_dataset_default_table_expiration as google_bigquery_dataset_default_table_expiration,
               jdd.gbd_google_bigquery_dataset_default_partition_expiration as google_bigquery_dataset_default_partition_expiration,
               jdd.gbd_google_bigquery_dataset_short_description as google_bigquery_dataset_short_description,
               -- Permissions Details:
               jdd.gcr_google_cloud_role_role as role_type,
               '"groupByEmail"' as permission_type,
               'job' as dataset_prefix,
               odted.o_organisation_identifier as organisation_identifier,
               jdd.j_job_name as dataset_name_pt1,
               null as dataset_name_pt2,
               null as permissions_email_override,              
               odted.o_organisation_email_domain as organisation_email_domain
        from permissions_meta.job_datasets_denorm jdd
            inner join permissions_meta.employee_jobs ej
                on jdd.j_job_id = ej.job_id    
            inner join permissions_meta.organisation_department_team_employees_denorm odted
                on ej.employee_id = odted.e_employee_id 
        union
        /*
            Employees:
        */
        select distinct
               -- Identifiers:
               edd.gbd_google_cloud_project_id as internal_google_cloud_project_id,
               edd.gcp_google_cloud_project_name as google_cloud_project_name,
               edd.gbd_google_bigquery_dataset_id as internal_google_bigquery_dataset_id,
               edd.gbd_google_bigquery_dataset_name as google_bigquery_dataset_name,
               -- Dataset Detail:
               edd.gcl_google_cloud_location_name as google_cloud_location_name,
               edd.gbd_google_bigquery_dataset_default_table_expiration as google_bigquery_dataset_default_table_expiration,
               edd.gbd_google_bigquery_dataset_default_partition_expiration as google_bigquery_dataset_default_partition_expiration,
               edd.gbd_google_bigquery_dataset_short_description as google_bigquery_dataset_short_description,
               -- Permissions Details:
               edd.gcr_google_cloud_role_role as role_type,
               '"userByEmail"' as permission_type,
               'emp' as dataset_prefix,
               odted.o_organisation_identifier as organisation_identifier,
               edd.e_family_name as dataset_name_pt1,
               edd.e_given_name as dataset_name_pt2,
               null as permissions_email_override,              
               odted.o_organisation_email_domain as organisation_email_domain
        from permissions_meta.employee_datasets_denorm edd    
            inner join permissions_meta.organisation_department_team_employees_denorm odted
                on edd.e_employee_id = odted.e_employee_id 
        union
        /*
            Service Accounts:
        */
        select distinct
               -- Identifiers:
               sadd.gbd_google_cloud_project_id as internal_google_cloud_project_id,
               sadd.gcp_google_cloud_project_name as google_cloud_project_name,
               sadd.gbd_google_bigquery_dataset_id as internal_google_bigquery_dataset_id,
               sadd.gbd_google_bigquery_dataset_name as google_bigquery_dataset_name,
               -- Dataset Detail:
               sadd.gcl_google_cloud_location_name as google_cloud_location_name,
               sadd.gbd_google_bigquery_dataset_default_table_expiration as google_bigquery_dataset_default_table_expiration,
               sadd.gbd_google_bigquery_dataset_default_partition_expiration as google_bigquery_dataset_default_partition_expiration,
               sadd.gbd_google_bigquery_dataset_short_description as google_bigquery_dataset_short_description,
               -- Permissions Details:
               sadd.gcr_google_cloud_role_role as role_type,
               '"userByEmail"' as permission_type,
               'sa' as dataset_prefix,
               odtgsa.o_organisation_identifier as organisation_identifier,
               sadd.gcsa_google_cloud_service_account_name as dataset_name_pt1,
               null as dataset_name_pt2,
               sadd.gcsa_google_cloud_service_account_email as permissions_email_override,
               odtgsa.o_organisation_email_domain as organisation_email_domain
        from permissions_meta.service_account_datasets_denorm sadd    
            inner join permissions_meta.organisation_department_team_google_service_accounts_denorm odtgsa
                on sadd.gcsa_google_cloud_service_account_id = odtgsa.gcsa_google_cloud_service_account_id                                                                                                    
    ),
    dataset_data as (
        select distinct ddb.internal_google_cloud_project_id,
                       ddb.google_cloud_project_name,
                       ddb.internal_google_bigquery_dataset_id,
                       ddb.google_bigquery_dataset_name,
                       concat('--location=', ddb.google_cloud_location_name) as location_command_part,
                       case when (ddb.google_bigquery_dataset_default_table_expiration <> 0) then
                            concat('--default_table_expiration ', ddb.google_bigquery_dataset_default_table_expiration)
                       else 
                            -- There is not one, but cant supply null to concat command:
                            ''
                       end as default_table_expiration_command_part,   
                       case when (ddb.google_bigquery_dataset_default_partition_expiration <> 0) then
                            concat('--default_table_expiration ', ddb.google_bigquery_dataset_default_partition_expiration)
                       else 
                            -- There is not one, but cant supply null to concat command:
                            ''
                       end as default_partition_expiration_command_part,
                       case when (
                                    (ddb.google_bigquery_dataset_short_description is not null)
                                    and
                                    (ddb.google_bigquery_dataset_short_description <> '')
                                 ) then
                                    concat('--description ''', ddb.google_bigquery_dataset_short_description)
                            else
                                concat('--description ''', 'No Description at this time', '''')
                       end as dataset_description_command_part                                               
        from dataset_data_base ddb
    ),
    dataset_permissions_base as (
        select ddb.internal_google_cloud_project_id,
               ddb.google_cloud_project_name,
               ddb.internal_google_bigquery_dataset_id,
               ddb.google_bigquery_dataset_name,
               ddb.role_type,
               ddb.permission_type,               
               concat(
                        ddb.dataset_prefix, '-',
                        ddb.organisation_identifier, '-'                                                                  
               ) as authorised_group_name_start,
               replace(
                       lower(
                               case when (ddb.dataset_name_pt2 is not null) then 
                                    concat(ddb.dataset_name_pt1, '-', ddb.dataset_name_pt2)
                               else
                                   ddb.dataset_name_pt1
                               end 
                            ),
                       ' ',
                       '-'
                       )                             
                        as authorised_group_name_end,
               ddb.organisation_email_domain,
               ddb.permissions_email_override
        from dataset_data_base as ddb
    ),
    dataset_permissions as (
        select dpb.internal_google_cloud_project_id,
               dpb.google_cloud_project_name,
               dpb.internal_google_bigquery_dataset_id,
               dpb.google_bigquery_dataset_name,
               concat(
                    '{"role": "', 
                    dpb.role_type,
                    '", ',
                    dpb.permission_type, ':"',
                    case when (dpb.permissions_email_override is null) then
                        -- No override for a service account:
                        concat(
                                dpb.authorised_group_name_start,
                                dpb.authorised_group_name_end,
                                '@',
                                dpb.organisation_email_domain
                               )
                    else
                        -- This is a service account therefore own email:
                        dpb.permissions_email_override
                    end,                         
                    '"}'
               ) as permission_line              
        from dataset_permissions_base dpb
    ),
    dataset_permissions_grouped as (
        select dp.internal_google_cloud_project_id,
               dp.google_cloud_project_name,
               dp.internal_google_bigquery_dataset_id,
               dp.google_bigquery_dataset_name,
               concat(c.permissions_file_output_dir, dp.google_cloud_project_name, '-', dp.google_bigquery_dataset_name, '-permissions.json') as permissions_filepath, 
               group_concat(dp.permission_line separator ', ') as project_dataset_all_permissions
        from dataset_permissions dp,
             constants as c            
        group by dp.internal_google_cloud_project_id,
               dp.google_cloud_project_name,
               dp.internal_google_bigquery_dataset_id,
               dp.google_bigquery_dataset_name,
               concat(c.permissions_file_output_dir, dp.google_cloud_project_name, '-', dp.google_bigquery_dataset_name, '-permissions.json')
    )
select dd.internal_google_cloud_project_id,
       dd.google_cloud_project_name,
       dd.internal_google_bigquery_dataset_id,
       dd.google_bigquery_dataset_name,
       concat(
                'bq ', 
                dd.location_command_part,
                ' mk --dataset ',
                trim(dd.default_table_expiration_command_part), ' ',
                trim(dd.default_partition_expiration_command_part), ' ',
                dd.dataset_description_command_part, ' ',
                dd.google_cloud_project_name, ':', dd.google_bigquery_dataset_name
             ) as create_dataset_command,
       concat(
                'echo ''{ "access": [', 
                dpg.project_dataset_all_permissions ,
                '] }'' > ', 
                dpg.permissions_filepath
              ) as create_dataset_permissions_file_command,
       concat(
                'bq update --source ',
                dpg.permissions_filepath,
                ' ',
                dd.google_cloud_project_name, ':', dd.google_bigquery_dataset_name
             ) as replace_dataset_permissions_command,
       concat(
                'bq update',
                trim(dd.default_table_expiration_command_part), ' ',
                trim(dd.default_partition_expiration_command_part), ' ',
                dd.dataset_description_command_part, ' ',
                dd.google_cloud_project_name, ':', dd.google_bigquery_dataset_name
             ) as update_dataset_permissions_command       
from dataset_data dd
    left join dataset_permissions_grouped dpg
        on dd.internal_google_cloud_project_id = dpg.internal_google_cloud_project_id
            and dd.internal_google_bigquery_dataset_id = dpg.internal_google_bigquery_dataset_id
                           
            