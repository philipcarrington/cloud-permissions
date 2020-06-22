# For larking around with files:
import os
from configparser import ConfigParser

# For MySQL querying:
from mysql.connector import MySQLConnection, Error

# For connecting to Google using the service account:
from google.oauth2 import service_account

# For BigQuery Python API:
from google.cloud import bigquery
from google.cloud.exceptions import NotFound

###############################################################################
# General functions:
def get_dir_location(foldername):
    # Current Dir:
    current_dir = os.path.dirname(__file__)
    # Config files location:
    return os.path.join(current_dir, foldername)

def read_db_config(filename='db_cfg/config.ini', section='mysql'):
    """ Read database configuration file and return a dictionary object
    :param filename: name of the configuration file
    :param section: section of database configuration
    :return: a dictionary of database parameters
    """
    # create parser and read ini configuration file
    parser = ConfigParser()
    parser.read(filename)

    # get section, default to mysql
    db = {}
    if parser.has_section(section):
        items = parser.items(section)
        for item in items:
            db[item[0]] = item[1]
    else:
        raise Exception('{} not found in the {} file'.format(section, filename))

    return db

def api_call_logger(google_api_action, internal_google_cloud_project_id, internal_google_bigquery_dataset_id, api_call_logger_message):
    try:
        # Get the config file directory for the MySQL connection:
        configs_dir = get_dir_location('configs')
        # Create the MySQL config filepath:
        mysql_config_filepath = os.path.join(configs_dir, 'mysql_config.ini')

        # Create the query
        log_query = "insert into permissions_history.api_dataset_actions(" \
                    "   api_dataset_action_datetime," \
                    "   api_dataset_action_action_id," \
                    "   internal_project_id," \
                    "   internal_dataset_id," \
                    "   api_action_state_description" \
                    ")" \
                    "values(" \
                    "   now()," \
                    "   (select a.action_id from permissions_history.actions a where action_name = '{}')," \
                    "   {}," \
                    "   {}," \
                    "   '{}'" \
                    ")".format(google_api_action, internal_google_cloud_project_id,
                               internal_google_bigquery_dataset_id, api_call_logger_message)

        # Set the connection properties:
        db_config = read_db_config(
            filename=mysql_config_filepath
        )

        # Create the connection
        db_connection = MySQLConnection(**db_config)

        db_connection.autocommit = True
        cursor = db_connection.cursor()
        cursor.execute(log_query)

        if cursor.lastrowid:
            return cursor.lastrowid
        else:
            print('last insert id not found')

        db_connection.commit()
        db_connection.close()

    except Error as e:
        print(e)
    finally:
        if db_connection.is_connected():
            db_connection.close()
            cursor.close()

###############################################################################
# Google Auth functions:
def get_google_sa_account_creds(sa_json_key_filename):
    # Get the secrets dir:
    secrets_dir = get_dir_location('secrets')

    # Get the filepath
    json_key_filepath = os.path.join(secrets_dir, sa_json_key_filename)

    credentials = service_account.Credentials.from_service_account_file(
        json_key_filepath,
        scopes=["https://www.googleapis.com/auth/cloud-platform"],
    )

    return credentials

def get_client_connection(sa_credentials_filepath):
    # Get the credentials:
    credentials = get_google_sa_account_creds(sa_credentials_filepath)
    client = bigquery.Client(
        credentials=credentials,
        project=credentials.project_id,
    )

    return client

###############################################################################
# BigQuery functions:
def dataset_exists(dataset_id):
    # Get client connection:
    client = get_client_connection('resources-and-permissions-service-key.json')

    try:
        client.get_dataset(dataset_id)  # Make an API request.
        # print("Dataset {} already exists".format(dataset_id))
        return 1
    except NotFound:
        # print("Dataset {} is not found".format(dataset_id))
        return 0

def create_dataset(
        dataset_id,
        dataset_location,
        dataset_default_table_expiration,
        default_partition_expiration,
        dataset_short_description="None at this time"
):
    # Get client connection:
    client = get_client_connection('resources-and-permissions-service-key.json')

    # Construct a full Dataset object to send to the API.
    dataset = bigquery.Dataset(dataset_id)

    # Set the dataset options:
    dataset.location = dataset_location
    # TODO:
    # dataset.default_partition_expiration_ms = dataset_default_table_expiration
    # dataset.default_table_expiration_ms = default_partition_expiration
    dataset.description = dataset_short_description

    # Try and create the dataset:
    try:
        client.create_dataset(dataset)  # Make an API request.
        return 1
    except Error as e:
        print(e)
        return 0

###############################################################################
# Permission setting functions:
def create_update_datasets(project_name):
    # Get the config file directory for the MySQL connection:
    configs_dir = get_dir_location('configs')
    # Create the MySQL config filepath:
    mysql_config_filepath = os.path.join(configs_dir, 'mysql_config.ini')

    # Create the MySQL query string:
    query_string = "select distinct " \
                   "internal_google_cloud_project_id," \
                   "    google_cloud_project_name," \
                   "    internal_google_bigquery_dataset_id," \
                   "    google_bigquery_dataset_name," \
                   "    google_cloud_location_name," \
                   "    google_bigquery_dataset_default_table_expiration," \
                   "    google_bigquery_dataset_default_partition_expiration," \
                   "    google_bigquery_dataset_short_description " \
                   "from permissions_meta.gbq_dataset_create_update_commands_python gdcuc " \
                   "where gdcuc.google_cloud_project_name = '{}'".format(project_name)

    # print('Executing Query: {}'.format(query_string))

    # Set the connection properties:
    db_config = read_db_config(
        filename=mysql_config_filepath
    )

    # Create the connection
    db_connection = MySQLConnection(**db_config)

    cursor = db_connection.cursor()
    cursor.execute(query_string)
    records = cursor.fetchall()

    for row in records:
        # Data from the query:
        internal_google_cloud_project_id = row[0]
        google_cloud_project_name = row[1]
        internal_google_bigquery_dataset_id = row[2]
        google_bigquery_dataset_name = row[3]
        google_cloud_location_name = row[4]
        google_bigquery_dataset_default_table_expiration = row[5]
        google_bigquery_dataset_default_partition_expiration = row[6]
        google_bigquery_dataset_short_description = row[7]


        # Make some vars for the subsequent API calls:
        dataset_id = '{}.{}'.format(google_cloud_project_name, google_bigquery_dataset_name)

        # See if the dataset exists:
        if dataset_exists(dataset_id) == 1:
            # Dataset Exists:
            api_call_logger_message = 'Dataset already exists'
            api_call_logger('Create', internal_google_cloud_project_id, internal_google_bigquery_dataset_id,
                            api_call_logger_message)

        else:
            # Dataset does not exist create it:
            try:
                create_dataset(
                    dataset_id,
                    google_cloud_location_name,
                    google_bigquery_dataset_default_table_expiration,
                    google_bigquery_dataset_default_partition_expiration,
                    google_bigquery_dataset_short_description
                )

                api_call_logger_message = 'Dataset created'
            except Error as e:
                api_call_logger_message = e
            finally:
                api_call_logger('Create', internal_google_cloud_project_id, internal_google_bigquery_dataset_id,
                                api_call_logger_message)

#####################################################
# Run the Job:
if __name__ == "__main__":
    create_update_datasets('csuk-production')
    update_permissions_on_datasets('csuk-production')