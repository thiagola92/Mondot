extends Node

# TYPE_NIL means that it accept event if the field is missing
const schema = {
	"__type__": [TYPE_INT, TYPE_REAL],
	"name": [TYPE_STRING],
	"host": [TYPE_NIL, TYPE_STRING],
	"port": [TYPE_NIL, TYPE_INT],
}


static func _get_connection_values(connection : Dictionary):
	SchemaParseResult.result = {
		"__type__": connection['__type__'],
		'name': connection['name'],
		'host': connection['host'] if connection.get('host') != null else '127.0.0.1',
		'port': connection['port'] if connection.get('port') != null else 27017,
	}


static func parse(conn : Dictionary):
	var connection = conn.duplicate(true)
	
	if Schema.is_valid(connection, schema) == false:
		return SchemaParseResult
	
	_get_connection_values(connection)

	return SchemaParseResult
