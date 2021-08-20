extends Node


func _ready():
	pass


func _add_connection(tree : Tree, connection : Dictionary):
	var root = tree.get_root()
	var tree_item = tree.create_item(root)
	
	tree_item.set_text(0, connection["name"])
	tree_item.set_metadata(0, connection)


func _disconnect_connection(tree : Tree, tree_item : TreeItem):
	_remove_tree_item(tree_item)
	tree.update()


func _remove_tree_item(tree_item : TreeItem):
	tree_item.get_parent().remove_child(tree_item)
	tree_item.free()


func _refresh_connection(tree_item : TreeItem):
	pass
