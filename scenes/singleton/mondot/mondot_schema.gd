extends Node


# TYPE_NIL means that it accept even if the field is missing


const FOLDER = {
	"__type__": [TYPE_INT, TYPE_REAL],
	"name": [TYPE_STRING],
	
	# Once the folder is imported, there is no need for the field connections
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
	"uri": [TYPE_STRING],
}


const COLLECTION = {
	"__type__": [TYPE_INT, TYPE_REAL],
	"name": [TYPE_STRING],
	"uri": [TYPE_STRING],
	"db": [TYPE_STRING],
}
