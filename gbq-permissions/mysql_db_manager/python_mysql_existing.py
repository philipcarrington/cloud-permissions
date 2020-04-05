from mysql.connector import MySQLConnection, Error
from .python_mysql_dbconfig import read_db_config


def get_exisiting_google_cloud_project_id(configs_dir, project_name):
    try:
        # Create the query string:
        query_string = "select exisiting_google_cloud_project_id " \
                       "from exisiting_google_cloud_projects " \
                       "where exisiting_google_cloud_project_name = '{}'".format(project_name)

        db_config = read_db_config(
            filename='{}/mysql_config.ini'.format(configs_dir)
        )
        db_connection = MySQLConnection(**db_config)
        cursor = db_connection.cursor()
        cursor.execute(query_string)

        row = cursor.fetchone()

        while row is not None:
            print(row)
            row = cursor.fetchone()

    except Error as e:
        print(e)

def add_