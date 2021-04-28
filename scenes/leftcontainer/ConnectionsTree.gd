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
	
	add_connection({
		"_type_": CONNECTION,
		"name": "exemplo1",
	})
	add_connection({
		"_type_": CONNECTION,
		"name": "exemplo2",
	})


func add_connection(connection):
	var item = create_item(root)
	item.set_text(0, connection["name"])
	item.set_metadata(0, connection)


func _on_ConnectionsTree_item_rmb_selected(position):
	var item = get_item_at_position(position)
	$ConnectionMenu.rect_position = position
	$ConnectionMenu.popup()


func _on_ConnectionMenu_disconnect_pressed():
	var item = get_selected()
	root.remove_child(item)
	item.free()
	update()
