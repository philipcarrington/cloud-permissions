
import os
from gcp_utilities.gbq import *
from mysql_db_manager.python_mysql_existing import *


# Start setting up the relative paths:
# Current Dir:
current_dir = os.path.dirname(__file__)
# Config files location:
configs_dir = os.path.join(current_dir, 'configs')

# Set the project to be investigated:
project_name = 'hx-data-production'

# See if the project exists in the database or not
project_id = get_existing_google_cloud_project_id(configs_dir, project_name)
if project_id:
    print('Project EXISTS')
    print(project_id)
else:
    print('Needs adding to Db')
    project_id = add_existing_google_cloud_project_id(configs_dir, project_name)

# Get the existing datasets:
project_datasets = get_project_datasets(project_name)

# Cycle round the datasets and add detail to the database:
for project_dataset in project_datasets:
    # Get the dataset proper name:
    dataset_name = get_dataset_name(project_dataset.dataset_id)
    print(dataset_name)

    # Get the the information on the dataset:
    dataset_info = get_datasets_information(project_name, dataset_name)
    print(dataset_info)
    # Extract the data from the information:
    dataset_resource_type = get_dataset_resource_type_str(dataset_info)
    dataset_project = get_dataset_project_str(dataset_info)
    dataset_id = get_dataset_id_str(dataset_info)
    dataset_creation_time = get_dataset_creation_time_int(dataset_info)
    dataset_access_list = get_dataset_access_list_list(dataset_info)
    dataset_etag_str = get_dataset_etag_str(dataset_info)
    dataset_location_str = get_dataset_location_str(dataset_info)
    dataset_last_modified_time_str = get_dataset_last_modified_time_str(dataset_info)
    dataset_full_id_str = get_dataset_full_id_str(dataset_info)
    dataset_self_link_str = get_dataset_self_link_str(dataset_info)

    # Get the database dataset id:
    db_dataset_id = get_existing_google_cloud_dataset_id(configs_dir, dataset_name, project_id)
    if db_dataset_id:
        print('DATASET EXISTS')
        print(db_dataset_id)
    else:
        db_dataset_id = add_existing_google_cloud_dataset_id(configs_dir, dataset_name, project_id)

    # Get existing access groups:
    special_groups, group_groups, user_groups, views = process_dataset_access_list(dataset_access_list)

    # Load them into the database
    print(type(special_groups))
    if special_groups:
        existing_dataset_permission_group_type = 'specialGroup'
        for accessee, permission in special_groups.items():
            db_dataset_permission_id = get_existing_google_cloud_dataset_id(
                configs_dir,
                db_dataset_id,
                permission,
                accessee
            )
            if db_dataset_permission_id:
                print('permission entry exists')
            else:
                add_dataset_permission_id(configs_dir, db_dataset_id, permission, accessee)

            db_dataset_permission_id = get_existing_google_cloud_dataset_id(configs_dir,
                                                                            db_dataset_id,
                                                                            existing_dataset_permission_group_type,
                                                                            permission, accessee)

    print('Special Groups: {}'.format(special_groups))
    print('Group Groups: {}'.format(group_groups))
    print('User Groups: {}'.format(user_groups))
    print('Views: {}'.format(views))

    print("************************ END *********************")

