/*
    Stored procedure to normalise the action of the INSERT and UPDATE trigger
*/
create procedure permissions_meta.add_permissions_history_google_bigquery_datasets(
    in_google_bigquery_dataset_id                                  int,
	in_google_cloud_project_id                                     int,
	in_google_cloud_location_id                                    int,
	in_google_bigquery_dataset_name                                varchar(255),
	in_google_bigquery_dataset_short_description                   varchar(500),
	in_google_bigquery_dataset_default_table_expiration            smallint,
	in_google_bigquery_dataset_default_partition_expiration        smallint,
	in_google_bigquery_dataset_history_action                      smallint,
	in_google_bigquery_dataset_history_datetime                    datetime,
	in_google_bigquery_dataset_history_user                        varchar(255)
)
begin
    insert into permissions_history.google_bigquery_datasets(
        google_bigquery_dataset_id,
        google_cloud_project_id,
        google_cloud_location_id,
        google_bigquery_dataset_name,
        google_bigquery_dataset_short_description,
        google_bigquery_dataset_default_table_expiration,
        google_bigquery_dataset_default_partition_expiration,
        google_bigquery_dataset_history_action,
        google_bigquery_dataset_history_datetime,
        google_bigquery_dataset_history_user
    )
    values (
        in_google_bigquery_dataset_id,
        in_google_cloud_project_id,
        in_google_cloud_location_id,
        in_google_bigquery_dataset_name,
        in_google_bigquery_dataset_short_description,
        in_google_bigquery_dataset_default_table_expiration,
        in_google_bigquery_dataset_default_partition_expiration,
        in_google_bigquery_dataset_history_action,
        in_google_bigquery_dataset_history_datetime,
        in_google_bigquery_dataset_history_user
    );
end
go
/*
    ----------------------------------------------------------------------------
    INSERT trigger
    ----------------------------------------------------------------------------
*/
create trigger permissions_meta.after_insert_google_bigquery_datasets
after insert 
on permissions_meta.google_bigquery_datasets
for each row
begin
    set @action_id = (
                        select action_id 
                        from permissions_history.actions 
                        where action_name = 'Create'
                    );
    /*
        Call a common sp to add to the history table:       
    */
    call permissions_meta.add_permissions_history_google_bigquery_datasets
        (
            new.google_bigquery_dataset_id,
            new.google_cloud_project_id,
            new.google_cloud_location_id,
            new.google_bigquery_dataset_name,
            new.google_bigquery_dataset_short_description,
            new.google_bigquery_dataset_default_table_expiration,
            new.google_bigquery_dataset_default_partition_expiration,
            @action_id,
            now(),
            user()            
        );
end
go
/*
    ----------------------------------------------------------------------------
    UPDATE trigger
    ----------------------------------------------------------------------------
*/
create trigger permissions_meta.after_update_google_bigquery_datasets
after update 
on permissions_meta.google_bigquery_datasets
for each row
begin
    set @action_id = (
                        select action_id 
                        from permissions_history.actions 
                        where action_name = 'Amend'
                    );
    /*
        Call a common sp to add to the history table:       
    */
    call permissions_meta.add_permissions_history_google_bigquery_datasets
        (
            new.google_bigquery_dataset_id,
            new.google_cloud_project_id,
            new.google_cloud_location_id,
            new.google_bigquery_dataset_name,
            new.google_bigquery_dataset_short_description,
            new.google_bigquery_dataset_default_table_expiration,
            new.google_bigquery_dataset_default_partition_expiration,
            @action_id,
            now(),
            user()            
        );
end
go