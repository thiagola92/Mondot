extends Reference

const _Type = preload("res://scenes/utility/_type.gd")
const ConnectionParseResult = preload("res://scenes/utility/connection_parse_result.gd")

const example = {
	"_type_": 1,
	"name": "",
	"host": "",
	"port": ""
}

static func _erase_unnecessary_fields(connection : Dictionary):
	for k in connection.keys():
		if not k in example:
			connection.erase(k)


static func _add_missing_fields(connection : Dictionary):
	for key in example.keys():
		if not key in connection:
			connection[key] = example[key]


static func _are_types_valid(parse_result : Dictionary):
	var connection = parse_result.result
	
	for key in connection.keys():
		var current_type = _Type.of(connection[key])
		var expected_type = _Type.of(example[key])
		
		if current_type != expected_type:
			parse_result.error = ERR_INVALID_DATA
			parse_result.error_string = 'Field: %s \nExpected: %s \nReceived: %s' % [
				key, expected_type, current_type
			]
			
			return false
	return true


static func parse(connection : Dictionary):
	var parse_result = ConnectionParseResult.new(connection)
	
	_erase_unnecessary_fields(parse_result.result)
	_add_missing_fields(parse_result.result)
	
	if _are_types_valid(parse_result) == false:
		return parse_result

	return parse_result
