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


func _are_types_valid(connection : Dictionary):
	for field in connection.keys():
		var current_type = $Type.of(connection[field])
		var expected_type = $Type.of(example[field])
		
		if current_type != expected_type:
			$Alert.message('Field: %s \nExpected: %s \nReceived: %s' % [
				field, expected_type, current_type
			])
			
			return  false
			
	return true


func load_connection(connection : Dictionary):
	_erase_unnecessary_fields(connection)
	
	if not _are_types_valid(connection):
		return

	print(connection)
