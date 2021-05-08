extends Tree

enum {
	CONNECTION,
	FOLDER
}

var root


func _ready():
	root = create_item()


func _is_name_used(parent : TreeItem, name : String):
	var child = parent.get_children()
	
	while child != null:
		if child.get_text(0) == name:
			return true
		child = child.get_next()
	
	return false


func _create_item(parent : TreeItem, name : String, type : int):
	var child = create_item(parent)
	child.set_text(0, name)
	child.set_metadata(0, {'_type_': type})
	
	scroll_to_item(child)


func _create_folder(parent : TreeItem, name : String):
	_create_item(parent, name, FOLDER)


func _create_connection(parent : TreeItem, name : String):
	_create_item(parent, name, CONNECTION)


func _on_NewFolder_pressed():
	var name = 'New folder {count}'
	var count = 0
	
	while _is_name_used(root, name.format({'count': count})):
		count += 1
	
	_create_folder(root, name.format({'count': count}))


func _on_ConnectionsListTree_item_activated():
	get_selected().set_editable(0, true)
