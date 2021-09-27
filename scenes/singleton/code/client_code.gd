extends Node


func drop_collection(db : String) -> String:
	return 'self.client.drop_database("%s")' % db
