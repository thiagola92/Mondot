class_name QueryTemplates
extends Node


const COUNT_DOCUMENTS = """collection = self.db["COLLECTION"]

collection.count_documents({})
"""

const FIND_ONE = """
collection = self.db["COLLECTION"]

collection.find_one(
	{"FIELD": 1}
)
"""

const FIND_MANY = """collection = self.db["COLLECTION"]

collection.find(
	{"FIELD": 1}
)
"""

const INSERT_ONE = """collection = self.db["COLLECTION"]

collection.insert_one(
	{"FIELD": 1}
)
"""

const INSERT_MANY = """collection = self.db["COLLECTION"]

collection.insert_many([
	{"FIELD": 1},
	{"FIELD": 2},
	{"FIELD": 5},
	{"FIELD": 1},
])
"""

const UPDATE_ONE = """collection = self.db["COLLECTION"]

collection.update_one(
	{"_id": ObjectId()},
	{"$set": {"FIELD": 1}}
)
"""

const UPDATE_MANY = """collection = self.db["COLLECTION"]

collection.update_many(
	{"FIELD": 1},
	{"$inc": {"FIELD": 1}}
)
"""

const REPLACE_ONE = """collection = self.db["COLLECTION"]

collection.replace_one(
	{"_id": ObjectId()}
)
"""

const CREATE_INDEX = """from pymongo import ASCENDING, DESCENDING, GEO2D, GEOSPHERE, HASHED, TEXT

collection = self.db["COLLECTION"]

collection.create_index([
	("INDEX_NAME", ASCENDING),
])
"""

const COPY_TO = """source_collection = self.dbs[0]["COLLECTION_SOURCE"]
target_collection = self.dbs[1]["COLLECTION_TARGET"]

for doc in source_collection.find({}):
	target_collection.insert_one(doc)
"""

const COPY_BATCH_TO = """source_collection = self.dbs[0]["COLLECTION_SOURCE"]
target_collection = self.dbs[1]["COLLECTION_TARGET"]
batch_size = 1000
batch = []

for doc in source_collection.find({}):
	batch.append(doc)
	
	if len(batch) > batch_size:
		target_collection.insert_many(batch)
		batch.clear()

if batch:
	target_collection.insert_many(batch)
"""
