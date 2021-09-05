extends TreeDraggable


func _ready():
	var _root = create_item()


func _on_NewConnection_pressed():
	TreeItemKit.create_node(self, get_root(), {
		"__type__": MondotType.CONNECTION,
		"name": "New connection",
		"uri": "mongodb://127.0.0.1:27017"
	})


func _on_NewFolder_pressed():
	TreeItemKit.create_node(self, get_root(), {
		'__type__': MondotType.FOLDER,
		'name': "New folder",
		'connections': [],
	})


func _on_Import_connections_loaded(connections):
	for connection in connections:
		TreeItemKit.create_node(self, get_root(), connection)


func _on_ConnectionUri_loaded(connection):
	TreeItemKit.create_node(self, get_root(), connection)


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


func _on_Tree_connection_dropped_on_folder(dropped : TreeItem, folder : TreeItem):
	TreeItemKit.move_node_to_new_parent(self, dropped, folder)


func _on_Tree_folder_dropped_on_folder(dropped, folder):
	if dropped == folder:
		return
	
	if TreeItemKit.is_node_inside_parent(folder, dropped):
		return
		
	TreeItemKit.move_node_to_new_parent(self, dropped, folder)


func _on_Tree_connection_dropped_on_empty(dropped):
	TreeItemKit.move_node_to_new_parent(self, dropped, get_root())


func _on_Tree_folder_dropped_on_empty(dropped):
	TreeItemKit.move_node_to_new_parent(self, dropped, get_root())
