extends Tree

var root : TreeItem


func _ready():
	root = create_item()


func _is_name_used(parent : TreeItem, name : String):
	var child = parent.get_children()
	
	while child != null:
		if child.get_text(0) == name:
			return true
		child = child.get_next()
	
	return false


func _get_available_name(name : String, counter_name : String):
	var count = 0
	
	while _is_name_used(root, name.format({counter_name: count})):
		count += 1
	
	return name.format({counter_name: count})


func _create_node(parent : TreeItem, metadata : Dictionary):
	var child = create_item(parent)
	child.set_text(0, metadata['name'])
	child.set_metadata(0, metadata)
	
	if metadata['__type__'] == ConnectionType.FOLDER:
		for item in metadata['connections']:
			_create_node(child, item)
	
	scroll_to_item(child)


func _on_NewConnection_pressed():
	var name = _get_available_name('New connection {count}', 'count')
	_create_node(root, {
		'__type__': ConnectionType.CONNECTION,
		'name': name,
	})


func _on_NewFolder_pressed():
	var name = _get_available_name('New folder {count}', 'count')
	_create_node(root, {
		'__type__': ConnectionType.FOLDER,
		'name': name,
		'connections': [],
	})


func _on_Tree_item_activated():
	var metadata = get_selected().get_metadata(0)
	
	if metadata["__type__"] == ConnectionType.CONNECTION:
		print("open connection settings") # TODO


func _on_Import_connections_loaded(connections):
	for connection in connections:
		_create_node(root, connection)
