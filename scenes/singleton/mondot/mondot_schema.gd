extends Node

# Schemas are used to check if the dictionary have the desired properties.
# Is most usefull when importing configurations that could be adulterated by users.

const FOLDER = {
	"__type__": [TYPE_INT, TYPE_REAL],
	"name": [TYPE_STRING],
	
	# FIXME: should only accept TYPE_ARRAY
	# TYPE_NIL would mean that it accept even if the field is missing
	"connections": [TYPE_ARRAY, TYPE_NIL],
}


const CONNECTION = {
	"__type__": [TYPE_INT, TYPE_REAL],
	"name": [TYPE_STRING],
	"uri": [TYPE_STRING],
}


const DATABASE = {
	"__type__": [TYPE_INT, TYPE_REAL],
	"name": [TYPE_STRING],
	"uri": [TYPE_STRING]
}


const COLLECTION = {
	"__type__": [TYPE_INT, TYPE_REAL],
	"name": [TYPE_STRING],
	"uri": [TYPE_STRING],
	"db": [TYPE_STRING]
}
