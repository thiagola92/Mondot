extends Node


func import_mongoclient() -> String:
		return (
"""
from pymongo import MongoClient
"""
).lstrip("\n")
