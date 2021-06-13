extends Node

const Type = preload("res://scenes/utility/type.gd")
const ConnectionParseResult = preload("res://scenes/utility/connection/connection_parse_result.gd")

# TYPE_NIL means that it accept event if the field is missing
const structure = {
	"name": [TYPE_STRING],
	"host": [TYPE_NIL, TYPE_STRING],
	"port": [TYPE_NIL, TYPE_INT]
}


static func _are_types_valid(connection : Dictionary, parse_result : ConnectionParseResult):
	for key in structure.keys():
		if not typeof(connection.get(key)) in structure[key]:
			parse_result.error = ERR_INVALID_DATA
			parse_result.error_string = 'Unexpected %s in field "%s"' % [Type.of(connection.get(key)), key]
			
			return false
	return true


static func _get_connection_values(connection : Dictionary, parse_result : ConnectionParseResult):
	parse_result.result = {
		'name': connection['name'],
		'host': connection['host'] if connection.get('host') != null else '127.0.0.1',
		'port': connection['port'] if connection.get('port') != null else 27017,
	}


static func parse(conn : Dictionary):
	var connection = conn.duplicate(true)
	var parse_result = ConnectionParseResult.new()
	
	if _are_types_valid(connection, parse_result) == false:
		return parse_result
	
	_get_connection_values(connection, parse_result)

	return parse_result
