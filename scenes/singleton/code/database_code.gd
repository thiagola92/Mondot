extends Node


# Sort functions by:
# - Codes that read data
# - Codes that insert data
# - Codes that update data
# - Codes that remove data


func list_collection_names():
	return (
"""
sorted(self.db.list_collection_names())
"""
)


func show_database_stats() -> String:
	return (
"""
self.db.command("dbstats")
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


func copy_database_to_json(directory : String, files : Array, collections : Array) -> String:
	var code = ""
	
	for index in range(files.size()):
		code += CollectionCode.copy_collection_to_json(
			directory,
			files[index],
			collections[index]
		)
	
	return code


func copy_database_to_csv(directory : String, files : Array, collections : Array) -> String:
	var code = ""
	
	for index in range(files.size()):
		code += CollectionCode.copy_collection_to_csv(
			directory,
			files[index],
			collections[index]
		)
	
	return code
