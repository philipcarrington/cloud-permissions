from __future__ import absolute_import, division, print_function
# from airflow import DAG  # noqa: F401

# Set up the python path

from google.cloud import bigquery

from utility_functions import dictionary_key_exists


def create_google_client_connection(project):
    # Construct a BigQuery client object.
    client = bigquery.Client(
        project=project
    )
    return client


def get_project_datasets(gcp_name):
    gbq_connection = create_google_client_connection(gcp_name)
    datasets = list(gbq_connection.list_datasets())  # Make an API request.
    project = gbq_connection.project

    if datasets:
        return datasets
    else:
        print("{} project does not contain any datasets.".format(project))


def get_dataset_name(dataset_data):
    return dataset_data.encode('ascii', 'ignore')


def get_datasets_information(gcp_name, gbq_dataset_name):
    gbq_connection = create_google_client_connection(gcp_name)
    dataset_object = gbq_connection.get_dataset(gbq_dataset_name)
    return dataset_object.__dict__


def get_dataset_resource_type_str(dataset_data):
    return dataset_data['_properties']['kind']


def get_dataset_project_str(dataset_data):
    return dataset_data['_properties']['datasetReference']['projectId']


def get_dataset_id_str(dataset_data):
    return dataset_data['_properties']['datasetReference']['datasetId']


def get_dataset_creation_time_int(dataset_data):
    return dataset_data['_properties']['creationTime']


def get_dataset_access_list_list(dataset_data):
    return dataset_data['_properties']['access']


def get_dataset_etag_str(dataset_data):
    return dataset_data['_properties']['etag']


def get_dataset_location_str(dataset_data):
    return dataset_data['_properties']['location']


def get_dataset_last_modified_time_str(dataset_data):
    return dataset_data['_properties']['lastModifiedTime']


def get_dataset_full_id_str(dataset_data):
    return dataset_data['_properties']['id']


def get_dataset_self_link_str(dataset_data):
    return dataset_data['_properties']['selfLink']


def process_dataset_access_list(access_list):
    if access_list:
        special_group_dict = {}
        user_group_dict = {}
        group_group_dict = {}
        view_dict = {}
        for access_entry in dataset_access_list:
            # If it is a user not a view
            if dictionary_key_exists(access_entry, 'role'):
                # Get the role
                role_name = access_entry['role']

                if dictionary_key_exists(access_entry, 'specialGroup'):
                    special_group_dict[access_entry['specialGroup']] = role_name
                elif dictionary_key_exists(access_entry, 'userByEmail'):
                    user_group_dict[access_entry['userByEmail']] = role_name
                elif dictionary_key_exists(access_entry, 'groupByEmail'):
                    group_group_dict[access_entry['groupByEmail']] = role_name
            # A view
            else:
                view_dict.update(access_entry['view'])

        return special_group_dict, group_group_dict, user_group_dict, view_dict


project_name = 'hx-data-production'
project_datasets = get_project_datasets(project_name)
for project_dataset in project_datasets:
    print("************************ START *********************")
    print("************************ DATASET INFO *********************")
    print('The dataset is: {}'.format(get_dataset_name(project_dataset.dataset_id)))

    dataset_name = get_dataset_name(project_dataset.dataset_id)
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
    process_dataset_access_list(dataset_access_list)

    print("************************ END *********************")
