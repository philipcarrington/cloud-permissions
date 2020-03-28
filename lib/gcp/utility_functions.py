from __future__ import absolute_import, division, print_function
# from airflow import DAG  # noqa: F401

# TODO: Get imports to work properly

def dictionary_key_exists(search_dict, key):
    if key in search_dict.keys():
        return True
    else:
        return False