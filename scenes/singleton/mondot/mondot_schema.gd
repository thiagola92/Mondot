extends Node


# TYPE_NIL means that it accept event if the field is missing
const FOLDER = {
	"__type__": [TYPE_INT, TYPE_REAL],
	"name": [TYPE_STRING],
	"connections": [TYPE_ARRAY],
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
