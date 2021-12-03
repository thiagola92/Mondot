extends Node


func list_collection_names():
	return (
"""
sorted(self.db.list_collection_names())
"""
)


func copy_database(source_cols : Array, target_uri : String, target_dbs : Array, target_cols : Array) -> String:
	var code = ""
	
	for index in range(source_cols.size()):
		code += CollectionCode.copy_collection(
			source_cols[index],
			target_uri,
			target_dbs[index],
			target_cols[index]
		)
	
	return code
