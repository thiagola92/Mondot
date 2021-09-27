extends Node


func find(collection : String) -> String:
	return 'self.db["%s"].find()' % collection


func drop_collection(collection : String) -> String:
	return 'self.db["%s"].drop()' % collection


func move_collection(collection : String, uri_target : String, db_target : String) -> String:
	return "from pymongo import MongoClient\n\n" + \
	'client = MongoClient("%s")\n' % uri_target + \
	'db = client["%s"]\n\n' % db_target + \
	'for doc in self.db["%s"].find():\n' % collection + \
	'	db["%s"].insert(doc)\n\n' % collection + \
	'self.db.drop_collection("%s")' % collection
