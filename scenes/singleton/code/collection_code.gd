extends Node


func find(collection : String) -> String:
	return (
"""
self.db["%s"].find()
""" % [
	collection
])


func drop_collection(collection : String) -> String:
	return (
"""
self.db.drop_collection("%s")
""" % [
	collection
])


func copy_collection(source_col : String, target_uri : String, target_db : String, target_col : String) -> String:
		return (
"""
target_client = MongoClient("%s")
target_db = target_client["%s"]
target_col = target_db["%s"]

for doc in self.db["%s"].find():
	target_col.insert(doc)
""" % [
	target_uri,
	target_db,
	target_col,
	source_col
])


func move_collection(collection : String, target_uri : String, target_db : String, target_col : String) -> String:
	return (
"""
%s
%s
""" % [
	copy_collection(collection, target_uri, target_db, target_col),
	drop_collection(collection)
])
