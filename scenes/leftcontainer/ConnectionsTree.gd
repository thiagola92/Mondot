extends Tree

enum {
	CONNECTION,
	DATABASE,
	CLIENT
}

var root


func _ready():
	set_column_title(0, "Connections")
	set_column_titles_visible(true)
	
	root = create_item()
	
	_add_connection({
		"_type_": CONNECTION,
		"name": "exemplo1",
	})
	_add_connection({
		"_type_": CONNECTION,
		"name": "exemplo2",
	})


func _add_connection(connection : Dictionary):
	var item = create_item(root)
	item.set_text(0, connection["name"])
	item.set_metadata(0, connection)


func _on_ConnectionsTree_item_rmb_selected(position : Vector2):
	$ConnectionMenu.rect_position = position
	$ConnectionMenu.popup()


func _on_ConnectionMenu_disconnect_pressed():
	var item = get_selected()
	root.remove_child(item)
	item.free()
	update()
