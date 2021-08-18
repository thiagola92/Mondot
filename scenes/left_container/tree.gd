extends Tree


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
