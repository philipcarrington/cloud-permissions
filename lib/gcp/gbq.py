from __future__ import absolute_import, division, print_function
# from airflow import DAG  # noqa: F401

from google.cloud import bigquery


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
        #print(type(datasets))
        #print("Datasets in project {}:".format(project))
        #for dataset in datasets:
        #    print("\t{}".format(dataset.dataset_id))
        return datasets
    else:
        print("{} project does not contain any datasets.".format(project))


def get_dataset_name(dataset_data):
    return dataset_data.encode('ascii', 'ignore')


def get_datasets_information(gcp_name, gbq_dataset_name):
    gbq_connection = create_google_client_connection(gcp_name)

    dataset_name = get_dataset_name(gbq_dataset_name)

    dataset_object = gbq_connection.get_dataset(dataset_name)

    return dataset_object

def get_dataset_friendly_name(dataset_data):
    return dataset_data.friendly_name


def get_dataset_current_permissions(dataset_data):
    return list(dataset_data.access_entries)


def get_dataset_current_description(dataset_data):
    # returns strin
    return dataset_data.description


def get_dataset_current_labels(dataset_data):
    # returns dict
    return dataset_data.description

project_datasets = get_project_datasets('hx-trial-dev-pmc')
for project_dataset in project_datasets:
    print("************************ START *********************")
    print("************************ DATASET INFO *********************")
    print('The dataset is: {}'.format(get_dataset_name(project_dataset.dataset_id)))
    dataset_info = get_datasets_information('hx-trial-dev-pmc', project_dataset.dataset_id)
    print(get_dataset_friendly_name(dataset_info))
    print(get_dataset_current_permissions(dataset_info))
    print(get_dataset_current_description(dataset_info))
    print(get_dataset_current_labels(dataset_info))
    print("************************ END *********************")
