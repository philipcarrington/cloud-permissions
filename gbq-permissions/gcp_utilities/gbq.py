from __future__ import absolute_import, division, print_function

from google.cloud import bigquery

from .utilities.utility_functions import dictionary_key_exists


def create_google_client_connection(project):
    # Construct a BigQuery client object.
    client = bigquery.Client(
        project=project
    )
    return client


def get_project_datasets(gcp_name):
    gbq_connection = create_google_client_connection(gcp_name)
    datasets = list(gbq_connection.list_datasets())  # Make an API request.

    if datasets:
        return datasets
    else:
        print("{} project does not contain any datasets.".format(project))


def get_dataset_name(dataset_data):
    return dataset_data


def get_datasets_information(gcp_name, gbq_dataset_name):
    gbq_connection = create_google_client_connection(gcp_name)
    dataset_object = gbq_connection.get_dataset(gbq_dataset_name)
    print(dataset_object)
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
        for access_entry in access_list:
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
