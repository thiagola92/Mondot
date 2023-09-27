class_name QueryTemplates
extends Node


const COUNT_DOCUMENTS = """self.col.count_documents({})"""

const FIND_ONE = """
self.col.find_one(
	{"FIELD": 1}
)
"""

const FIND_MANY = """
self.col.find(
	{"FIELD": 1}
)
"""

const INSERT_ONE = """
self.col.insert_one(
	{"FIELD": 1}
)
"""

const INSERT_MANY = """
self.col.insert_many([
	{"FIELD": 1},
	{"FIELD": 2},
	{"FIELD": 5},
	{"FIELD": 1},
])
"""

const UPDATE_ONE = """
self.col.update_one(
	{"_id": ObjectId()},
	{"$set": {"FIELD": 1}}
)
"""

const UPDATE_MANY = """
self.col.update_many(
	{"FIELD": 1},
	{"$inc": {"FIELD": 1}}
)
"""

const REPLACE_ONE = """
self.col.replace_one(
	{"_id": ObjectId()}
)
"""

const CREATE_INDEX = """from pymongo import ASCENDING, DESCENDING, GEO2D, GEOSPHERE, HASHED, TEXT

self.col.create_index([
	("INDEX_NAME", ASCENDING),
])
"""

const COPY_TO = """source_collection = self.cols[0]
target_collection = self.cols[1]

for doc in source_collection.find({}):
	target_collection.insert_one(doc)
"""

const COPY_BATCH_TO = """source_collection = self.cols[0]
target_collection = self.cols[1]
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
