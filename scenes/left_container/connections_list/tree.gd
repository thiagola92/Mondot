extends Tree


func _ready():
	var _root = create_item()


func _on_NewConnection_pressed():
	var uri = "mongodb://127.0.0.1:27017"
	var parser_result = URIParser.parse(uri)
	
	if parser_result.error == OK:
		_create_node(get_root(), parser_result.result)


func _create_node(parent : TreeItem, metadata : Dictionary):
	var child = create_item(parent)
	child.set_text(0, metadata['name'])
	child.set_metadata(0, metadata)
	
	if metadata['__type__'] == MondotType.FOLDER:
		for item in metadata['connections']:
			_create_node(child, item)
	
	scroll_to_item(child)


func _on_NewFolder_pressed():
	_create_node(get_root(), {
		'__type__': MondotType.FOLDER,
		'name': "New folder",
		'connections': [],
	})


func _on_Import_connections_loaded(connections):
	for connection in connections:
		_create_node(get_root(), connection)


func _on_ConnectionUri_loaded(connection):
	_create_node(get_root(), connection)


func _on_Tree_item_rmb_selected(position : Vector2):
	var item = get_item_at_position(position)
	var metadata = item.get_metadata(0)
	
	if metadata['__type__'] == MondotType.CONNECTION:
		$ConnMenu.popup_on_mouse()


func _on_ConnMenu_edit_connection_pressed():
	var item = get_selected()
	var metadata = item.get_metadata(0)
	
	$ConnMenu/ConnectionSettings.set_connection(metadata)
	$ConnMenu/ConnectionSettings.popup_centered()


func _on_ConnectionSettings_save_pressed(connection : Dictionary):
	var item = get_selected()
	item.set_metadata(0, connection)
	item.set_text(0, connection["name"])
