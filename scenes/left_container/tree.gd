extends TreeDraggable

signal open_shell_pressed(uri, db, code)
signal collection_moved(uri, db, code)


func _ready():
	set_column_title(0, "Connections")
	set_column_titles_visible(true)
	create_item().set_text(0, "root")


func _on_ConnectionsList_item_selected(tree_item : TreeItem):
	$Connection.add_connection(self, tree_item.get_metadata(0))


func _on_Tree_item_rmb_selected(_position : Vector2):
	var metadata = get_selected().get_metadata(0)
	
	match metadata["__type__"]:
		MondotType.CONNECTION:
			$Connection/Menu.popup_on_mouse()
		MondotType.DATABASE:
			$Database/Menu.popup_on_mouse()
		MondotType.COLLECTION:
			$Collection/Menu.popup_on_mouse()


func _on_ConnectionMenu_id_pressed(id : int):
	var tree_item = get_selected()
	var connection = tree_item.get_metadata(0)
	
	match id:
		0:
			emit_signal("open_shell_pressed", connection["uri"], "admin", "")
		1:
			# open settings pressed
			pass
		2:
			# create database pressed
			pass
		3:
			$Connection.refresh_connection(self, tree_item)
		4:
			$Connection.disconnect_connection(self, tree_item)


func _on_DatabaseMenu_id_pressed(id : int):
	var tree_item = get_selected()
	var database = tree_item.get_metadata(0)
	
	match id:
		0:
			emit_signal("open_shell_pressed", database["uri"], database["name"], "")
		1:
			pass
		2:
			pass
		3:
			$Database.refresh_database(self, tree_item)
		4:
			pass


func _on_CollectionMenu_id_pressed(id : int):
	var tree_item = get_selected()
	var collection = tree_item.get_metadata(0)
	
	match id:
		0:
			emit_signal(
				"open_shell_pressed",
				collection["uri"],
				collection["db"],
				CollectionCode.find(collection["name"])
			)


func _on_Tree_item_activated():
	var tree_item = get_selected()
	var metadata = tree_item.get_metadata(0)
	
	match metadata["__type__"]:
		MondotType.CONNECTION:
			$Connection.refresh_connection(self, tree_item)
		MondotType.DATABASE:
			$Database.refresh_database(self, tree_item)


func _on_Tree_collection_dropped_on_database(dropped : TreeItem, database : TreeItem):
	if dropped.get_parent() == database:
		return
		
	var collection = dropped.get_metadata(0)
	var db = database.get_metadata(0)
	
	emit_signal(
		"collection_moved",
		collection["uri"],
		collection["db"],
		CollectionCode.clone_collection(collection["name"], db["uri"], db["name"])
	)
