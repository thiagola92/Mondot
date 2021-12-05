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


func copy_collection_to_json(directory : String, file : String, collection : String) -> String:
		return (
"""
file = "%s/%s.json"
first_line = True

with open(file, "w") as f:
	for doc in self.db["%s"].find():
		if not first_line:
			f.write("\\n")
		
		f.write(json_util.dumps(
			doc, json_options=json_util.RELAXED_JSON_OPTIONS
		))
		
		first_line = False
""" % [
	directory,
	file,
	collection
])


func copy_collection_to_csv(directory : String, file : String, collection : String) -> String:
		return (
"""
file = "%s/%s.csv"
writer = None

with open(file, "w") as f:
	for doc in self.db["%s"].find():
		if not writer:
			writer = DictWriter(f, fieldnames=doc.keys())
		writer.writerow(doc)
""" % [
	directory,
	file,
	collection
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
