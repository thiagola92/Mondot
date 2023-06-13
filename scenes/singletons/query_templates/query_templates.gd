extends Node


const COUNT_DOCUMENTS = """self.db["COLLECTION"].count_documents({})"""

const FIND_ONE = """self.db["COLLECTION"].find_one({})"""

const FIND_MANY = """self.db["COLLECTION"].find({})"""

const INSERT_ONE = """self.db["COLLECTION"].insert_one({})"""

const INSERT_MANY = """self.db["COLLECTION"].insert_many([{}])"""

const UPDATE_ONE = """self.db["COLLECTION"].update_one({})"""

const UPDATE_MANY = """self.db["COLLECTION"].update_many({})"""

const REPLACE_ONE = """self.db["COLLECTION"].replace_one({})"""
