extends Tree

signal open_shell_pressed(connection)
signal open_settings_pressed(connection)
signal create_database_pressed(connection)
signal refresh_pressed(connection)
signal disconnect_pressed(connection)


func _ready():
	set_column_title(0, "Connections")
	set_column_titles_visible(true)
	create_item().set_text(0, "root")


func _on_Tree_item_rmb_selected(_position : Vector2):
	var metadata = get_selected().get_metadata(0)
	
	if metadata["__type__"] == MondotType.CONNECTION:
		$ConnMenu.popup_on_mouse()


func _on_Menu_disconnect_pressed():
	var item = get_selected()
	item.get_parent().remove_child(item)
	item.free()
	update()


func _on_ConnectionsList_item_selected(item):
	var connection = create_item(get_root())
	
	connection.set_text(0, item.get_text(0))
	connection.set_metadata(0, item.get_metadata(0))


func _on_ConnMenu_id_pressed(id):
	var item = get_selected()
	var connection = item.get_metadata(0)
	
	match id:
		0:
			emit_signal("open_shell_pressed", connection)
		1:
			emit_signal("open_settings_pressed", connection)
		2:
			emit_signal("create_database_pressed", connection)
		3:
			emit_signal("refresh_pressed", connection)
		4:
			emit_signal("disconnect_pressed", connection)
