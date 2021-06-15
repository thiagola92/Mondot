extends Tree


enum {
	CONNECTION,
	DATABASE,
	CLIENT
}


func _ready():
	set_column_title(0, "Connections")
	set_column_titles_visible(true)
	
	create_item()


func _on_Tree_item_rmb_selected(position : Vector2):
	$Menu.rect_position = position
	$Menu.popup()


func _on_Menu_disconnect_pressed():
	var item = get_selected()
	item.get_parent().remove_child(item)
	item.free()
	update()


func _on_ConnectionsList_item_selected(item):
	pass # Replace with function body.
