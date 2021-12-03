extends Node


func list_database_names():
	return (
"""
sorted(self.client.list_database_names())
"""
)


func drop_database(db : String) -> String:
	return (
"""
self.client.drop_database("%s")
""" % [
	db
])
