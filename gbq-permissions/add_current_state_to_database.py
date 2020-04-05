
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
    print('EXISTS')
else:
    print('Needs adding to Db')
    project_id = add_existing_google_cloud_project_id(configs_dir, project_name)

# Get the existing datasets:
project_datasets = get_project_datasets(project_name)

# Cycle round the datasets and add detail to the database:
for project_dataset in project_datasets:



    dataset_name = get_dataset_name(project_dataset.dataset_id)
    # print(type(dataset_name))
    # print(type(dataset_name.decode('utf-8')))
    dataset_info = get_datasets_information(project_name, dataset_name)
    dataset_resource_type = get_dataset_resource_type_str(dataset_info)
    dataset_project = get_dataset_project_str(dataset_info)
    dataset_id = get_dataset_id_str(dataset_info)
    dataset_creation_time = get_dataset_creation_time_int(dataset_info)
    dataset_access_list= get_dataset_access_list_list(dataset_info)
    dataset_etag_str = get_dataset_etag_str(dataset_info)
    dataset_location_str= get_dataset_location_str(dataset_info)
    dataset_last_modified_time_str= get_dataset_last_modified_time_str(dataset_info)
    dataset_full_id_str = get_dataset_full_id_str(dataset_info)
    dataset_self_link_str = get_dataset_self_link_str(dataset_info)


    print(type(dataset_name))
    print(dataset_name)
    print(type(dataset_info))
    print(dataset_info)
    print(type(dataset_resource_type))
    print(dataset_resource_type)
    print(type(dataset_project))
    print(dataset_project)
    print(type(dataset_id))
    print(dataset_id)
    print(type(dataset_creation_time))
    print(dataset_creation_time)
    print(type(dataset_access_list))
    print(dataset_access_list)
    print(type(dataset_etag_str))
    print(dataset_etag_str)
    print(type(dataset_location_str))
    print(dataset_location_str)
    print(type(dataset_last_modified_time_str))
    print(dataset_last_modified_time_str)
    print(type(dataset_full_id_str))
    print(dataset_full_id_str)
    print(type(dataset_self_link_str))
    print(dataset_self_link_str)

    print("Iterate through the access list:")
    special_groups, group_groups, user_groups, views = process_dataset_access_list(dataset_access_list)
    print('Special Groups: {}'.format(special_groups))
    print('Group Groups: {}'.format(group_groups))
    print('User Groups: {}'.format(user_groups))
    print('Views: {}'.format(views))

    print("************************ END *********************")

