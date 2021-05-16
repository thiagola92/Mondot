extends FileDialog

signal connections_loaded(connections)

const Connection = preload("res://scenes/utility/connection.gd")


func _ready():
	# For test purpose only
	if get_tree().get_root().get_child(0) == $".":
		popup_centered()
	
	set_filters(PoolStringArray(["*.json ; JSON File"]))


func _read_file(path : String) -> String:
	var file = File.new()
	
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	
	return content


func _load_json(text : String):
	var json = JSON.parse(text)
	
	if json.error != OK:
		$Alert.message("Line %s\n%s" % [str(json.error_line), json.error_string])
		return []
	
	return json.result


func _load_connections(json) -> Array:
	var connections = []
	
	if typeof(json) != TYPE_ARRAY:
		$Alert.message("JSON imported is not an array of connections")
		return []
	
	for connection in json:
		connection = Connection.parse(connection)
		
		if connection.error != OK:
			$Alert.message(connection.error_string)
			return []
		
		connections.append(connection.result)
	
	return connections


func _on_Import_file_selected(path):
	var content = _read_file(path)
	var json = _load_json(content)
	var connections = _load_connections(json)
	
	emit_signal("connections_loaded", connections)
