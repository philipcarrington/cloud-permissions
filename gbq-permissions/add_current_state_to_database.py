
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
print(project_name)
# See if the project exists in the database or not
project_id = get_existing_google_cloud_project_id(configs_dir, project_name)
print(project_id)
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
        print('++++++++++++++++++++++++ DATASET EXISTS +++++++++++++++++++++++++++++++++')
    else:
        db_dataset_id = add_existing_google_cloud_dataset_id(configs_dir, dataset_name, project_id)
        print('The dataset database ID is :{}'.format(db_dataset_id))

    # Get existing access groups:
    special_groups, group_groups, user_groups, views = process_dataset_access_list(dataset_access_list)

    # Load them into the database
    if special_groups:
        existing_dataset_permission_group_type = 'specialGroup'
        for accessee, permission in special_groups.items():
            db_dataset_permission_id = get_existing_dataset_permission_id(
                configs_dir,
                db_dataset_id,
                existing_dataset_permission_group_type,
                permission,
                accessee
            )

            if db_dataset_permission_id:
                print('The permission: {} for: {} ALREADY exists: {}'.format(permission, accessee, db_dataset_permission_id))
            else:
                db_dataset_permission_id = add_dataset_permission_id(configs_dir, db_dataset_id,
                                                                     existing_dataset_permission_group_type,
                                                                     permission, accessee)
                print('The permission: {} for: {} NOW exists: {}'.format(permission, accessee, db_dataset_permission_id))


    if group_groups:
        existing_dataset_permission_group_type = 'groupByEmail'
        for accessee, permission in group_groups.items():
            db_dataset_permission_id = get_existing_dataset_permission_id(
                configs_dir,
                db_dataset_id,
                existing_dataset_permission_group_type,
                permission,
                accessee
            )
            if db_dataset_permission_id:
                print('The permission: {} for: {} ALREADY exists: {}'.format(permission, accessee, db_dataset_permission_id))
            else:
                db_dataset_permission_id = add_dataset_permission_id(configs_dir, db_dataset_id,
                                                                     existing_dataset_permission_group_type,
                                                                     permission, accessee)
                print('The permission: {} for: {} NOW exists: {}'.format(permission, accessee, db_dataset_permission_id))

    if user_groups:
        print('*********************** There are user_groups ***********************')
        print(user_groups)
        existing_dataset_permission_group_type = 'userByEmail'
        for accessee, permission in user_groups.items():
            print('*********************** user_group ***********************')
            print(accessee)
            print(permission)
            db_dataset_permission_id = get_existing_dataset_permission_id(
                configs_dir,
                db_dataset_id,
                existing_dataset_permission_group_type,
                permission,
                accessee
            )
            if db_dataset_permission_id:
                print('The permission: {} for: {} ALREADY exists: {}'.format(permission, accessee, db_dataset_permission_id))
            else:
                db_dataset_permission_id = add_dataset_permission_id(configs_dir, db_dataset_id,
                                                                     existing_dataset_permission_group_type,
                                                                     permission, accessee)
                print('The permission: {} for: {} NOW exists: {}'.format(permission, accessee, db_dataset_permission_id))

    if views:
        print('*********************** There are views ***********************')
        print(views)
        existing_dataset_permission_group_type = 'view'
        view_permission = 'READER'
        for projectname, accessee in views.items():
            print(projectname)
            print(accessee)
            db_dataset_permission_id = get_existing_dataset_permission_id(
                configs_dir,
                db_dataset_id,
                existing_dataset_permission_group_type,
                view_permission,
                accessee
            )
            if db_dataset_permission_id:
                print('************ {} Permission exists ************'.format(existing_dataset_permission_group_type))
            else:
                db_dataset_permission_id = add_dataset_permission_id(configs_dir, db_dataset_id,
                                                                     existing_dataset_permission_group_type,
                                                                     view_permission, accessee)
            print('************ Permission ID: {} ************'.format(existing_dataset_permission_group_type))
            print(db_dataset_permission_id)

    print("************************ END *********************")

