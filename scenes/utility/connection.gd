extends Reference

const Type = preload("res://scenes/utility/type.gd")
const ConnectionParseResult = preload("res://scenes/utility/connection_parse_result.gd")

const structure = {
	"name": [TYPE_STRING],
	"host": [TYPE_STRING],
	"port": [TYPE_INT]
}


static func _get_connection_values(connection : Dictionary, parse_result : ConnectionParseResult):
	parse_result.result = {
		'name': connection['name'],
		'host': connection.get('host', '127.0.0.1'),
		'port': connection.get('port', 27017),
	}


static func _are_types_valid(connection : Dictionary, parse_result : ConnectionParseResult):
	for key in structure.keys():
		if not typeof(connection.get(key)) in structure[key]:
			parse_result.error = ERR_INVALID_DATA
			parse_result.error_string = 'Unexpected type %s in field %s' % [Type.of(connection[key]), key]
			
			return false
	return true


static func parse(conn : Dictionary):
	var connection = conn.duplicate(true)
	var parse_result = ConnectionParseResult.new()
	
	if _are_types_valid(connection, parse_result) == false:
		return parse_result
	
	_get_connection_values(connection, parse_result)

	return parse_result
