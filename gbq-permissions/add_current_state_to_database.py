
import os
from gcp_utilities.gbq import *
from mysql_db_manager.python_mysql_existing import *


def get_configs_dir_location():
    # Current Dir:
    current_dir = os.path.dirname(__file__)
    # Config files location:
    return os.path.join(current_dir, 'configs')


def add_group_dataset_permissions_to_database(group_permission_dataset_id, group_permission_data, permission_group_name):
    # Get the configs Dir Location
    configs_dir = get_configs_dir_location()

    if group_permission_data:
        for accessee, permission in group_permission_data.items():
            db_dataset_permission_id = get_existing_dataset_group_permission_id(
                configs_dir,
                group_permission_dataset_id,
                permission_group_name,
                permission,
                accessee
            )

            if db_dataset_permission_id is None:
                # Add it:
                add_dataset_group_permission_id(configs_dir, group_permission_dataset_id, permission_group_name,
                                                permission, accessee, None, None)


def add_view_dataset_permissions_to_database(view_permission_dataset_id, view_dataset_data, view_table_name_data):
    # Get the configs Dir Location
    configs_dir = get_configs_dir_location()

    db_dataset_permission_id = get_existing_dataset_view_permission_id(
        configs_dir,
        view_permission_dataset_id,
        view_dataset_data,
        view_table_name_data
    )

    if db_dataset_permission_id is None:
        # Add it:
        add_dataset_group_permission_id(configs_dir, view_permission_dataset_id, 'View',
                                        'READER', None, view_dataset_data, view_table_name_data)


def add_project_google_big_query_exisitng_to_database(in_project_name):
    # Get the configs Dir Location
    configs_dir = get_configs_dir_location()

    # See if the project exists in the database or not
    # print('********************** Starting fetching process for: {} **********************'.format(in_project_name))
    project_id = get_existing_google_cloud_project_id(configs_dir, in_project_name)

    if project_id is None:
        project_id = add_existing_google_cloud_project_id(configs_dir, in_project_name)

    # print('***************** The project: {} has the ID of: {} *****************'.format(in_project_name, project_id))

    # Get the existing datasets:
    project_datasets = get_project_datasets(in_project_name)

    # Cycle round the datasets and add detail to the database:
    for project_dataset in project_datasets:
        # Get the dataset proper name:
        dataset_name = get_dataset_name(project_dataset.dataset_id)
        # print('*************** Investigating dataset: {} ********************'.format(dataset_name))

        # Get the the information on the dataset:
        dataset_info = get_datasets_information(in_project_name, dataset_name)
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
        if db_dataset_id is None:
            db_dataset_id = add_existing_google_cloud_dataset_id(configs_dir, dataset_name, project_id,
                                                                 dataset_self_link_str, dataset_full_id_str,
                                                                 dataset_last_modified_time_str,
                                                                 dataset_creation_time, dataset_location_str,
                                                                 dataset_etag_str, dataset_id)
        # else:
            # print('++++++++++++++++++++++++ DATASET EXISTS +++++++++++++++++++++++++++++++++')

        print('The dataset database ID is :{}'.format(db_dataset_id))
        print(dataset_access_list)
        # Get existing access groups:
        special_groups, group_by_email, user_by_email, views = process_dataset_access_list(dataset_access_list)

        add_group_dataset_permissions_to_database(db_dataset_id, special_groups, 'specialGroup')
        add_group_dataset_permissions_to_database(db_dataset_id, group_by_email, 'groupByEmail')
        add_group_dataset_permissions_to_database(db_dataset_id, user_by_email, 'userByEmail')

        view_dataset = None
        view_table_name = None

        if views:
            # print('********* There are VIEWS in dataset ID: {}, name: {} ***************'.format(db_dataset_id,
            #                                                                                     dataset_name))
            for key, value in views.items():
                if key in 'datasetId':
                    view_dataset = value
                elif key in 'tableId':
                    view_table_name = value

        add_view_dataset_permissions_to_database(db_dataset_id, view_dataset, view_table_name)
        # print("************************ END *********************")


#####################################################
# Run the Job:


if __name__ == "__main__":
    add_project_google_big_query_exisitng_to_database('hx-data-production')

