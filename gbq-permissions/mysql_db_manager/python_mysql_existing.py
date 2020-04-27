from mysql.connector import MySQLConnection, Error
from .python_mysql_dbconfig import read_db_config


def get_existing_google_cloud_project_id(configs_dir, project_name):
    try:
        # Create the query string:
        query_string = "select existing_google_cloud_project_id " \
                       "from existing_google_cloud_projects " \
                       "where existing_google_cloud_project_name = '{}'".format(project_name)
        print(query_string)

        # Set the connection properties:
        db_config = read_db_config(
            filename='{}/mysql_config.ini'.format(configs_dir)
        )

        # Create the connection
        db_connection = MySQLConnection(**db_config)

        cursor = db_connection.cursor()
        cursor.execute(query_string)
        records = cursor.fetchall()

        for row in records:
            return row[0]

    except Error as e:
        print("Error reading data from MySQL table", e)
    finally:
        if db_connection.is_connected():
            db_connection.close()
            cursor.close()
            print("MySQL connection is closed")


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

        records = cursor.fetchall()
        for row in records:
            return row[0]

    except Error as e:
        print('{} for SQL: {}'.format(e, query_string))
    finally:
        if db_connection.is_connected():
            db_connection.close()
            cursor.close()
            print("MySQL connection is closed")


def get_existing_dataset_permission_id(
        configs_dir,
        db_dataset_id,
        permission_group_type,
        permission,
        accessee
):
    try:
        # Create the query string:
        query_string = "select existing_dataset_permission_id " \
                       "from existing_dataset_permissions " \
                       "where existing_google_big_query_dataset_id = {}" \
                       " and existing_dataset_permission_group_type = '{}' " \
                       " and existing_dataset_permission_permission = '{}'" \
                       " and existing_dataset_permission_accessor = '{}'".format(db_dataset_id,
                                                                                 permission_group_type, permission,
                                                                                 accessee)
        print(query_string)
        db_config = read_db_config(
            filename='{}/mysql_config.ini'.format(configs_dir)
        )
        db_connection = MySQLConnection(**db_config)
        db_connection.autocommit = True
        cursor = db_connection.cursor()
        cursor.execute(query_string)

        records = cursor.fetchall()
        for row in records:
            return row[0]

    except Error as e:
        print('{} for SQL: {}'.format(e, query_string))
    finally:
        if db_connection.is_connected():
            db_connection.close()
            cursor.close()
            print("MySQL connection is closed")


def add_existing_google_cloud_project_id(configs_dir, project_name):
    try:
        # Create the query string:
        query_string = "insert into existing_google_cloud_projects (existing_google_cloud_project_name) " \
                       "values ('{}')".format(project_name)

        db_config = read_db_config(
            filename='{}/mysql_config.ini'.format(configs_dir)
        )
        db_connection = MySQLConnection(**db_config)
        db_connection.autocommit = True
        cursor = db_connection.cursor()
        cursor.execute(query_string)

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
            print("MySQL connection is closed")


def add_existing_google_cloud_dataset_id(configs_dir, dataset_name, project_id, dataset_self_link,
                                         dataset_full_id, dataset_last_modified_time, dataset_creation_time,
                                         dataset_location, dataset_etag, dataset_id):
    try:
        # Create the query string:
        query_string = "INSERT INTO existing_google_big_query_datasets \
                        ( \
                            existing_google_big_query_dataset_name, \
                            existing_google_big_query_project_id, \
                            existing_google_big_query_dataset_self_link, \
                            existing_google_big_query_dataset_full_id, \
                            existing_google_big_query_dataset_last_modified_time, \
                            existing_google_big_query_dataset_creation_time, \
                            existing_google_big_query_dataset_location, \
                            existing_google_big_query_dataset_etag, \
                            existing_google_big_query_dataset_dataset_id \
                        ) \
                    VALUES \
                        ( \
                            '{}', \
                            {}, \
                            '{}', \
                            '{}', \
                            '{}', \
                            '{}', \
                            '{}', \
                            '{}', \
                            '{}' \
                        )".format(dataset_name, project_id, dataset_self_link,
                                  dataset_full_id, dataset_last_modified_time, dataset_creation_time,
                                  dataset_location, dataset_etag, dataset_id)

        db_config = read_db_config(
            filename='{}/mysql_config.ini'.format(configs_dir)
        )
        db_connection = MySQLConnection(**db_config)
        db_connection.autocommit = True
        cursor = db_connection.cursor()
        cursor.execute(query_string)

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
            print("MySQL connection is closed")


def add_dataset_group_permission_id(configs_dir, db_dataset_id, dataset_permission_group_type, permission, accessee):
    try:
        # Create the query string:
        query_string = "insert into existing_dataset_permissions(" \
                       "existing_google_big_query_dataset_id, existing_dataset_permission_group_type," \
                       "existing_dataset_permission_permission, existing_dataset_permission_accessor) " \
                       "values ({}, '{}', '{}', '{}' )".format(db_dataset_id, dataset_permission_group_type,
                                                               permission, accessee)

        print(query_string)
        db_config = read_db_config(
            filename='{}/mysql_config.ini'.format(configs_dir)
        )
        db_connection = MySQLConnection(**db_config)
        db_connection.autocommit = True
        cursor = db_connection.cursor()
        cursor.execute(query_string)

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
            print("MySQL connection is closed")
