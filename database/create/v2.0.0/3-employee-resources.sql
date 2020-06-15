drop view permissions_meta.employee_resources_details_bigquery
go
create view permissions_meta.employee_resources_details_bigquery as (
    select base.employee_prefix,
           base.o_organisation_identifier as organisation_identifier,
           base.employee_name,
           base.employee_suffix,
           base.organisation_email_domain,
           base.google_cloud_project_id,
           base.google_cloud_location_id,
           base.google_bigquery_dataset_short_description,
           base.e_employee_id,
           base.gcr_google_cloud_role_id,
           concat(
                    base.employee_prefix, '-',
                    base.o_organisation_identifier, '-',
                    lower(base.employee_name), '-',
                    base.employee_suffix
                 ) as google_bigquery_dataset_name
    from (
            select distinct
                        --------------------------------------------------------
                        -- To make up the names:
                        'emp' as  employee_prefix,
                        odted.o_organisation_identifier,
                        concat(erd.e_given_name, '-', erd.e_family_name) as employee_name,
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
    ) as base
)                                
go

drop procedure permissions_meta.employee_resources_to_services_google_bigquery
go
create procedure permissions_meta.employee_resources_to_services_google_bigquery()
begin
    /*
        Purpose: To take the resources that are currently being requested
                 for the subject and create then in the tables that are 
                 used to create the commands to send to the provider
    */
    
    /*
        ------------------------------------------------------------------------
        Google BigQuery:
        ------------------------------------------------------------------------
    */
    
    /*
        Insert the new ones
            -- Trigger will fire
    */
    insert into permissions_meta.google_bigquery_datasets(
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
           grdb.google_bigquery_dataset_name,
           grdb.google_bigquery_dataset_short_description,              
           0 as google_bigquery_dataset_default_table_expiration, -- TODO: Put a field in the table to specify this
           0 as google_bigquery_dataset_default_partition_expiration -- TODO: Put a field in the table to specify this                           
    from permissions_meta.employee_resources_details_bigquery grdb
    where not exists (
                        select null
                        from permissions_meta.google_bigquery_datasets gbd
                        where gbd.google_cloud_project_id = grdb.google_cloud_project_id
                            and gbd.google_cloud_location_id = grdb.google_cloud_location_id
                            and gbd.google_bigquery_dataset_name = grdb.google_bigquery_dataset_name
    );
    
    /*
        Update the existing the new ones
            -- Trigger will fire
    */
    update google_bigquery_datasets gbd
    inner join (
                    select grdb.google_cloud_project_id,
                           grdb.google_cloud_location_id,
                           grdb.google_bigquery_dataset_name,
                           grdb.google_bigquery_dataset_short_description,              
                           0 as google_bigquery_dataset_default_table_expiration, -- TODO: Put a field in the table to specify this
                           0 as google_bigquery_dataset_default_partition_expiration -- TODO: Put a field in the table to specify this                           
                    from permissions_meta.employee_resources_details_bigquery grdb               
                ) as update_base
        on gbd.google_cloud_project_id = update_base.google_cloud_project_id
            and gbd.google_cloud_location_id = update_base.google_cloud_location_id
            and gbd.google_bigquery_dataset_name = update_base.google_bigquery_dataset_name
            and gbd.google_bigquery_dataset_short_description <> update_base.google_bigquery_dataset_short_description
            /*
                TODO: Need to add these columns into the data model:
                
                and gbd.google_bigquery_dataset_default_table_expiration <> 0 --grdb.google_bigquery_dataset_default_table_expiration 
                and gbd.google_bigquery_dataset_default_partition_expiration <> 0 --grdb.google_bigquery_dataset_default_partition_expiration
            */                                         
    set gbd.google_bigquery_dataset_short_description = update_base.google_bigquery_dataset_short_description,
        gbd.google_bigquery_dataset_default_table_expiration = update_base.google_bigquery_dataset_default_table_expiration,
        gbd.google_bigquery_dataset_default_partition_expiration = update_base.google_bigquery_dataset_default_partition_expiration;
                                  
    /*
        Subject dataset table:
    */
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
            on erdb.google_bigquery_dataset_name = gbd.google_bigquery_dataset_name
    where not exists (
                        select null 
                        from employee_datasets ed
                        where ed.employee_id = erdb.e_employee_id                                                 
                            and ed.google_bigquery_dataset_id = gbd.google_bigquery_dataset_id
                            /*
                                TODO: Could the role change?
                                and ed.google_cloud_role_id = erdb.google_cloud_role_id
                            */                                   
                     );            
      
end
go

/*
    Example call:
*/
call permissions_meta.employee_resources_to_services_google_bigquery()
go