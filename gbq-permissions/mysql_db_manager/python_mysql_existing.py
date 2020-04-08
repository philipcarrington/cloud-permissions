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

        if row[0]:
            return row[0]
        else:
            return None

    except Error as e:
        print(e)


def get_existing_google_cloud_dataset_id(configs_dir, dataset_name, project_id):
    try:
        # Create the query string:
        query_string = "select existing_google_big_query_dataset_id " \
                       "from existing_google_big_query_datasets " \
                       "where existing_google_big_query_dataset_name = '{}'" \
                       "    and existing_google_big_query_project_id = {}".format(dataset_name, project_id)
        print(query_string)
        db_config = read_db_config(
            filename='{}/mysql_config.ini'.format(configs_dir)
        )
        db_connection = MySQLConnection(**db_config)
        cursor = db_connection.cursor()
        cursor.execute(query_string)

        row = cursor.fetchone()
        if row:
            return row[0]
        else:
            return None

    except Error as e:
        print('{} for SQL: {}'.format(e, query_string))


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


def add_existing_google_cloud_dataset_id(configs_dir, dataset_name, project_id):
    try:
        # Create the query string:
        query_string = "insert into existing_google_big_query_datasets " \
                       "(existing_google_big_query_project_id, existing_google_big_query_dataset_name) " \
                       "values ({}, '{}')".format(project_id, dataset_name)

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


def add_dataset_permission_id(configs_dir, db_dataset_id, dataset_permission_group_type, permission, accessee):
    try:
        # Create the query string:
        query_string = "insert into existing_dataset_permissions " \
                       "(existing_google_big_query_dataset_id, existing_dataset_permission_group_type," \
                       "existing_dataset_permission_permission, existing_dataset_permission_accessor) " \
                       "values ({}, '{}')".format(db_dataset_id, dataset_permission_group_type,
                                                  permission, accessee)

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
