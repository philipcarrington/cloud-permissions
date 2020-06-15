import os
from configparser import ConfigParser
from mysql.connector import MySQLConnection, Error

def get_configs_dir_location():
    # Current Dir:
    current_dir = os.path.dirname(__file__)
    # Config files location:
    return os.path.join(current_dir, 'configs')

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

def get_permissions(project_name):
    # Get the config file directory for the MySQL connection:
    configs_dir = get_configs_dir_location()
    # Create the MySQL config filepath:
    mysql_config_filepath = os.path.join(configs_dir, 'mysql_config.ini')

    # Create the MySQL query string:

    # Set the connection properties:
    db_config = read_db_config(
        filename=mysql_config_filepath
    )

    # Create the connection
    db_connection = MySQLConnection(**db_config)






#####################################################
# Run the Job:
if __name__ == "__main__":
    get_permissions('csuk-production')