extends Node

# TYPE_NIL means that it accept event if the field is missing
const schema = {
	"__type__": [TYPE_INT, TYPE_REAL],
	"name": [TYPE_STRING],
	"connections": [TYPE_ARRAY],
}


static func _get_folder_values(folder : Dictionary):
	SchemaParseResult.result = {
		'__type__': folder['__type__'],
		'name': folder['name'],
		'connections': folder['connections'],
	}


static func parse(conn : Dictionary):
	var folder = conn.duplicate(true)
	
	if Schema.is_valid(folder, schema) == false:
		return SchemaParseResult
	
	_get_folder_values(folder)

	return SchemaParseResult
