extends FileDialog


signal connections_loaded(connections)


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()
	
	set_filters(PoolStringArray(["*.json ; JSON File"]))
	
	# This is a fix
	# When you select any filter option, it will write on LineEdit that filter option
	_get_option_button().connect("item_selected", self, "_on_OptionButton_item_selected")

func _get_option_button():
	return _get_last_hbox().get_child(2)


func _get_last_hbox():
	return get_vbox().get_child(3)


func _on_OptionButton_item_selected(_index):
	get_line_edit().text = ""


func _on_Import_file_selected(path):
	var content = _read_file(path)
	var json = _load_json(content)
	var connections = _import_json(json)
	
	emit_signal("connections_loaded", connections)


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


func _import_json(json) -> Array:
	if typeof(json) == TYPE_ARRAY:
		return _load_items(json)
	
	return []


func _load_items(json : Array) -> Array:
	var items = []
	
	for item in json:
		if typeof(item) != TYPE_DICTIONARY:
			continue
			
		if item.get("__type__") == null:
			continue
		
		if typeof(item["__type__"]) == TYPE_REAL:
			item["__type__"] = int(item["__type__"])
		
		if not _is_schema_valid(item):
			continue
		
		if item["__type__"] == MondotType.FOLDER:
			item["connections"] = _load_items(item["connections"])
		
		items.append(item)
	
	return items


func _is_schema_valid(item : Dictionary) -> bool:
	var schema_result = GenericResult.new(ERR_INVALID_DATA, "No schema provided")
	
	match item.get("__type__"):
		MondotType.FOLDER:
			schema_result = Schema.validate(item, MondotSchema.FOLDER)
		MondotType.CONNECTION:
			schema_result = Schema.validate(item, MondotSchema.CONNECTION)
	
	return schema_result.error == OK
