with 
    constants as (
        select '/tmp/' as permissions_file_output_dir
    ),
    dataset_data_base as (
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
               odtdd.o_organisation_email_domain as organisation_email_domain
        from permissions_meta.organisation_department_team_datasets_denorm odtdd
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
               ddb.organisation_email_domain
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
                    dpb.authorised_group_name_start,
                    dpb.authorised_group_name_end,
                    '@',
                    dpb.organisation_email_domain,
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
                           
            