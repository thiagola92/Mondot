extends Node


func list_database_names():
	return "self.client.list_database_names()"


func drop_database(db : String) -> String:
	return 'self.client.drop_database("%s")' % db


func get_all_collections() -> String:
	return '{' + \
		'db: self.client[db].list_collection_names()'  + \
		'for db in self.client.list_database_names()' + \
	'}'
