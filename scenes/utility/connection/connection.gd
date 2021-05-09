extends Node

enum Error {
	OK,
	INVALID_TYPE,
}

const example = {
	"_type_": 1,
	"name": "",
	"host": "",
	"port": ""
}


func _ready():
	pass
	load_connection({'asdf': 123, "_type_": '1'})


func _erase_unnecessary_fields(connection : Dictionary):
	for k in connection.keys():
		if not k in example:
			connection.erase(k)


func _add_missing_fields(connection : Dictionary):
	for key in example.keys():
		if not key in connection:
			connection[key] = example[key]


func _are_types_valid(connection : Dictionary):
	for key in connection.keys():
		var current_type = $Type.of(connection[key])
		var expected_type = $Type.of(example[key])
		
		if current_type != expected_type:
			$Alert.message('Field: %s \nExpected: %s \nReceived: %s' % [
				key, expected_type, current_type
			])
			
			return  false
	return true


func load_connection(connection : Dictionary):
	_erase_unnecessary_fields(connection)
	_add_missing_fields(connection)
	
	if _are_types_valid(connection) == false:
		return

	print(connection)
