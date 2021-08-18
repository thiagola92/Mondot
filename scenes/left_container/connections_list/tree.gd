extends Tree


func _ready():
	create_item()


func _on_NewConnection_pressed():
	var name = _get_available_name('New connection {count}', 'count')
	_create_node(get_root(), {
		'__type__': MondotType.CONNECTION,
		'name': name,
	})


func _get_available_name(name : String, counter_name : String):
	var count = 0
	
	while _is_name_used(get_root(), name.format({counter_name: count})):
		count += 1
	
	return name.format({counter_name: count})


func _is_name_used(parent : TreeItem, name : String):
	var child = parent.get_children()
	
	while child != null:
		if child.get_text(0) == name:
			return true
		child = child.get_next()
	
	return false


func _create_node(parent : TreeItem, metadata : Dictionary):
	var child = create_item(parent)
	child.set_text(0, metadata['name'])
	child.set_metadata(0, metadata)
	
	if metadata['__type__'] == MondotType.FOLDER:
		for item in metadata['connections']:
			_create_node(child, item)
	
	scroll_to_item(child)


func _on_NewFolder_pressed():
	var name = _get_available_name('New folder {count}', 'count')
	_create_node(get_root(), {
		'__type__': MondotType.FOLDER,
		'name': name,
		'connections': [],
	})


func _on_Import_connections_loaded(connections):
	for connection in connections:
		_create_node(get_root(), connection)


func _on_Tree_item_rmb_selected(position : Vector2):
	var item = get_item_at_position(position)
	var metadata = item.get_metadata(0)
	
	if metadata['__type__'] == MondotType.CONNECTION:
		$ConnMenu.popup_on_mouse()


func _on_ConnectionUri_loaded(connection):
	_create_node(get_root(), connection)
