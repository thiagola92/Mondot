extends Tree

enum {
	CONNECTION,
	FOLDER
}

var root : TreeItem


func _ready():
	root = create_item()


func load_connections(connections : Array):
	for connection in connections:
		print(connection)


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


func _create_node(parent : TreeItem, name : String, metadata : Dictionary):
	var child = create_item(parent)
	child.set_text(0, name)
	child.set_metadata(0, metadata)
	
	scroll_to_item(child)


func _create_folder(parent : TreeItem, name : String):
	_create_node(parent, name, {
		'_type_': FOLDER,
		'name': name
	})


func _create_connection(parent : TreeItem, name : String):
	_create_node(parent, name, {
		'_type_': CONNECTION,
		'name': name
	})


func _on_NewFolder_pressed():
	var name = _get_available_name('New folder {count}', 'count')
	_create_folder(root, name)


func _on_NewConnection_pressed():
	var name = _get_available_name('New connection {count}', 'count')
	_create_connection(root, name)


func _on_Tree_item_activated():
	var metadata = get_selected().get_metadata(0)
	
	if metadata["_type_"] == CONNECTION:
		print("connect with mongo") # TODO


func _on_Import_connections_loaded(connections):
	for connection in connections:
		_create_node(root, connection['name'], connection)
