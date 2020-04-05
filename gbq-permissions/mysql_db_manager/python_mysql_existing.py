from mysql.connector import MySQLConnection, Error
from .python_mysql_dbconfig import read_db_config


def get_existing_google_cloud_project_id(configs_dir, project_name):
    try:
        # Create the query string:
        query_string = "select existing_google_cloud_project_id " \
                       "from existing_google_cloud_projects " \
                       "where existing_google_cloud_project_name = '{}'".format(project_name)

        db_config = read_db_config(
            filename='{}/mysql_config.ini'.format(configs_dir)
        )
        db_connection = MySQLConnection(**db_config)
        cursor = db_connection.cursor()
        cursor.execute(query_string)

        row = cursor.fetchone()

        return row[0]

    except Error as e:
        print(e)


def get_existing_google_cloud_dataset_id(configs_dir, project_name):
    try:
        # Create the query string:
        query_string = "select existing_google_cloud_project_id " \
                       "from existing_google_cloud_projects " \
                       "where existing_google_cloud_project_name = '{}'".format(project_name)

        db_config = read_db_config(
            filename='{}/mysql_config.ini'.format(configs_dir)
        )
        db_connection = MySQLConnection(**db_config)
        cursor = db_connection.cursor()
        cursor.execute(query_string)

        row = cursor.fetchone()

        return row[0]

    except Error as e:
        print(e)


def add_existing_google_cloud_project_id(configs_dir, project_name):
    try:
        # Create the query string:
        query_string = "insert into existing_google_cloud_projects (existing_google_cloud_project_name) " \
                       "values ('{}')".format(project_name)

        db_config = read_db_config(
            filename='{}/mysql_config.ini'.format(configs_dir)
        )
        db_connection = MySQLConnection(**db_config)
        cursor = db_connection.cursor()
        cursor.execute(query_string)

        if cursor.lastrowid:
            return cursor.lastrowid
        else:
            print('last insert id not found')

        db_connection.commit()
    except Error as e:
        print(e)
    finally:
        cursor.close()
        db_connection.close()
