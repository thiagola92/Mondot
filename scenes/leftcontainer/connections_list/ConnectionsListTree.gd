extends Tree

enum {
	CONNECTION,
	FOLDER
}

var root : TreeItem


func _ready():
	root = create_item()


func _is_name_used(parent : TreeItem, name : String):
	var child = parent.get_children()
	
	while child != null:
		if child.get_text(0) == name:
			return true
		child = child.get_next()
	
	return false


func _create_folder(parent : TreeItem, name : String):
	var child = create_item(parent)
	child.set_text(0, name)
	child.set_metadata(0, {
		'_type_': FOLDER,
		'name': name
	})
	
	scroll_to_item(child)


func _create_connection(parent : TreeItem, name : String):
	var child = create_item(parent)
	child.set_text(0, name)
	child.set_metadata(0, {
		'_type_': CONNECTION,
		'name': name
	})
	
	scroll_to_item(child)


func _on_NewFolder_pressed():
	var name = 'New folder {count}'
	var count = 0
	
	while _is_name_used(root, name.format({'count': count})):
		count += 1
	
	_create_folder(root, name.format({'count': count}))


func _on_ConnectionsListTree_item_activated():
	var metadata = get_selected().get_metadata(0)
	
	if metadata["_type_"] == CONNECTION:
		print("connect with mongo") # TODO
