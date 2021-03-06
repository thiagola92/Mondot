class_name TreeDraggable, "res://images/icon_tree.svg"
extends Tree


signal folder_dropped_on_folder(dropped, folder)
signal connection_dropped_on_folder(dropped, folder)
signal collection_dropped_on_database(dropped, database)
signal connection_dropped_on_empty(dropped)
signal folder_dropped_on_empty(dropped)


func get_drag_data(position):
	return get_item_at_position(position)


func can_drop_data(position, data):
	var item = get_item_at_position(position)
	var type = _get_type(item)
	
	match type:
		MondotType.FOLDER:
			return _can_drop_data_on_folder(data)
		MondotType.DATABASE:
			return _can_drop_data_on_database(data)
		null:
			return _can_drop_data_on_empty(data)
	
	return false
	

func drop_data(position, data):
	var item = get_item_at_position(position)
	var type = _get_type(item)
	
	match type:
		MondotType.FOLDER:
			_drop_data_on_folder(item, data)
		MondotType.DATABASE:
			_drop_data_on_database(item, data)
		null:
			return _drop_data_on_empty(data)


func _get_type(item):
	if item != null:
		return item.get_metadata(0).get("__type__")
	return null


func _can_drop_data_on_folder(data):
	var type = _get_type(data)
	
	match type:
		MondotType.FOLDER:
			return true
		MondotType.CONNECTION:
			return true
	
	return false


func _drop_data_on_folder(folder, data):
	var type = _get_type(data)
	
	match type:
		MondotType.FOLDER:
			emit_signal("folder_dropped_on_folder", data, folder)
		MondotType.CONNECTION:
			emit_signal("connection_dropped_on_folder", data, folder)


func _can_drop_data_on_database(data):
	var type = _get_type(data)
	
	match type:
		MondotType.COLLECTION:
			return true
	
	return false


func _drop_data_on_database(database, data):
	var type = _get_type(data)
	
	match type:
		MondotType.COLLECTION:
			emit_signal("collection_dropped_on_database", data, database)


func _can_drop_data_on_empty(data):
	var type = _get_type(data)
	
	match type:
		MondotType.FOLDER:
			return true
		MondotType.CONNECTION:
			return true
	
	return false


func _drop_data_on_empty(data):
	var type = _get_type(data)
	
	match type:
		MondotType.FOLDER:
			emit_signal("folder_dropped_on_empty", data)
		MondotType.CONNECTION:
			emit_signal("connection_dropped_on_empty", data)
	
