extends Tree

var root


func _ready():
	set_column_title(0, "Connections")
	set_column_titles_visible(true)
	
	root = create_item()
	
	add_connection({"text": "exemplo1"})
	add_connection({"text": "exemplo2"})


func _on_ConnectionsTree_item_rmb_selected(position):
	var item = get_item_at_position(position)
	$ConnectionMenu.rect_position = position
	$ConnectionMenu.popup()
#	print(item.get_text(0))
#	print(item.get_metadata(0))


func add_connection(connection_details):
	var item = create_item(root)
	item.set_text(0, connection_details["text"])
#	item.set_metadata(0, connection_details)
