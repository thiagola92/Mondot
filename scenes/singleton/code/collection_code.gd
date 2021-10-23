extends Node


func find(collection : String) -> String:
	return \
"""
self.db["%s"].find()
""" % collection


func drop_collection(collection : String) -> String:
	return \
"""
self.db.drop_collection("%s")
""" % collection


func copy_collection(collection : String, uri_target : String, db_target : String) -> String:
		return """
from pymongo import MongoClient

target_client = MongoClient("%s")
target_db = target_client["%s"]
target_col = target_db["%s"]

for doc in self.db["%s"].find():
	target_col.insert(doc)
""" % [uri_target, db_target, collection, collection]


func move_collection(collection : String, uri_target : String, db_target : String) -> String:
	return """
%s
%s
""" % [
	copy_collection(collection, uri_target, db_target),
	drop_collection(collection)
]
