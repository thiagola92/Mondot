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


func _load_folder(json : Dictionary):
	var folder = Folder.parse(json)
	
	if folder.error != OK:
		$Alert.message(folder.error_string)
		return []
	
	folder.result['connections'] = _import_connections(folder.result['connections'])
	
	return [folder.result]


func _load_connection(json : Dictionary):
	var connection = Connection.parse(json)
	
	if connection.error != OK:
		$Alert.message(connection.error_string)
		return []
	
	return [connection.result]


func _load_item(json : Dictionary):
	if json.get('__type__') == ConnectionType.FOLDER:
		return _load_folder(json)
	
	if json.get('__type__') == ConnectionType.CONNECTION:
		return _load_connection(json)
	
	return []


func _load_items(json : Array):
	var items = []
	
	for item in json:
		items.append_array(_import_connections(item))
	
	return items


func _import_connections(json):
	if typeof(json) == TYPE_DICTIONARY:
		return _load_item(json)
	
	if typeof(json) == TYPE_ARRAY:
		return _load_items(json)
	
	return []


func _on_Import_file_selected(path):
	var content = _read_file(path)
	var json = _load_json(content)
	var connections = _import_connections(json)
	
	emit_signal("connections_loaded", connections)
