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


func copy_collection(col_source : String, uri_target : String, db_target : String, col_target : String) -> String:
		return """
target_client = MongoClient("%s")
target_db = target_client["%s"]
target_col = target_db["%s"]

for doc in self.db["%s"].find():
	target_col.insert(doc)
""" % [uri_target, db_target, col_target, col_source]


func move_collection(collection : String, uri_target : String, db_target : String, col_target : String) -> String:
	return """
%s
%s
""" % [
	copy_collection(collection, uri_target, db_target, col_target),
	drop_collection(collection)
]
