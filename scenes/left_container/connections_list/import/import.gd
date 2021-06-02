extends FileDialog

signal connections_loaded(connections)


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
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


func _load_connection(json : Dictionary):
	var connection = Connection.parse(json)
	
	if connection.error != OK:
		$Alert.message(connection.error_string)
		return null
	
	return connection.result


func _load_connections(json : Array):
	var connections = []
	
	for connection in json:
		var conn = _load_connection(connection)
		
		if conn == null:
			continue
			
		connections.append(conn)
	
	return connections


func _import_connections(json):
	if typeof(json) == TYPE_DICTIONARY:
		return _load_connections([json])
	
	if typeof(json) == TYPE_ARRAY:
		return _load_connections(json)
	
	return []


func _on_Import_file_selected(path):
	var content = _read_file(path)
	var json = _load_json(content)
	var connections = _import_connections(json)
	
	emit_signal("connections_loaded", connections)
