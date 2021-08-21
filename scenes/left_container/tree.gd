extends Tree

signal open_shell_pressed(connection)


func _ready():
	set_column_title(0, "Connections")
	set_column_titles_visible(true)
	create_item().set_text(0, "root")


func _on_Tree_item_rmb_selected(_position : Vector2):
	var metadata = get_selected().get_metadata(0)
	
	match metadata["__type__"]:
		MondotType.CONNECTION:
			$ConnMenu.popup_on_mouse()


func _on_ConnMenu_id_pressed(id : int):
	var tree_item = get_selected()
	var connection = tree_item.get_metadata(0)
	
	match id:
		0:
			emit_signal("open_shell_pressed", connection)
		1:
			# open settings pressed
			pass
		2:
			# create database pressed
			pass
		3:
			$ConnMethods.refresh_connection(self, tree_item)
		4:
			$ConnMethods.disconnect_connection(self, tree_item)


func _on_Tree_item_double_clicked():
	$ConnMethods.refresh_connection(self, get_selected())


func _on_ConnectionsList_item_selected(tree_item : TreeItem):
	$ConnMethods.add_connection(self, tree_item.get_metadata(0))
