extends WindowDialog


func _ready():
	# For test purpose only
	if get_tree().get_root().get_child(0) == $".":
		popup_centered()


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


func _on_Import_file_selected(path : String):
	var content = _read_file(path)
	var connections = _load_json(content)
	$Container/Tree.load_connections(connections)
