extends Node


func import_mongoclient() -> String:
		return (
"""
from pymongo import MongoClient
"""
)


func import_json_util() -> String:
		return (
"""
from bson import json_util
"""
)


func import_dict_writer() -> String:
		return (
"""
from csv import DictWriter
"""
)
