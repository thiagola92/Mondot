extends Node


func list_collection_names():
	return \
"""
self.db.list_collection_names()
"""


func copy_database(col_sources : Array, uri_target : String, db_target : String, col_targets : Array) -> String:
	var code = ""
	
	for index in range(col_sources.size()):
		code += CollectionCode.copy_collection(
			col_sources[index],
			uri_target,
			db_target,
			col_targets[index]
		)
	
	return code
