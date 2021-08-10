extends Node


# TYPE_NIL means that it accept event if the field is missing
const CONNECTION = {
	"__type__": [TYPE_INT, TYPE_REAL],
	"name": [TYPE_STRING],
	"host": [TYPE_NIL, TYPE_STRING],
	"port": [TYPE_NIL, TYPE_INT],
}


const FOLDER = {
	"__type__": [TYPE_INT, TYPE_REAL],
	"name": [TYPE_STRING],
	"connections": [TYPE_ARRAY],
}
