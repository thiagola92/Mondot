extends Node


const COUNT_DOCUMENTS = """self.db["COLLECTION"].count_documents({})"""

const FIND_ONE = """self.db["COLLECTION"].find_one(
	{"FIELD": 1}
)"""

const FIND_MANY = """self.db["COLLECTION"].find(
	{"FIELD": 1}
)"""

const INSERT_ONE = """self.db["COLLECTION"].insert_one(
	{"FIELD": 1}
)"""

const INSERT_MANY = """self.db["COLLECTION"].insert_many([
	{"FIELD": 1},
	{"FIELD": 2},
	{"FIELD": 5},
	{"FIELD": 1},
])"""

const UPDATE_ONE = """self.db["COLLECTION"].update_one(
	{"_id": ObjectId()},
	{"$set": {"FIELD": 1}}
)"""

const UPDATE_MANY = """self.db["COLLECTION"].update_many(
	{"FIELD": 1},
	{"$inc": {"FIELD": 1}}
)"""

const REPLACE_ONE = """self.db["COLLECTION"].replace_one(
	{"_id": ObjectId()}
)
"""

const CREATE_INDEX = """from pymongo import ASCENDING, DESCENDING, GEO2D, GEOSPHERE, HASHED, TEXT

self.db["COLLECTION"].create_index([
	("INDEX_NAME", ASCENDING),
])
"""
