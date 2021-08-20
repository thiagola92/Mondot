extends Node


func _ready():
	pass


func add_connection(tree : Tree, connection : Dictionary):
	var root = tree.get_root()
	var tree_item = tree.create_item(root)
	
	tree_item.set_text(0, connection["name"])
	tree_item.set_metadata(0, connection)


func disconnect_connection(tree : Tree, tree_item : TreeItem):
	_remove_tree_item(tree_item)
	tree.update()


func refresh_connection(tree_item : TreeItem):
	_remove_childrens(tree_item)
	
	var connection = tree_item.get_metadata(0)
	var code = "self.client.list_database_names()"
	var uri = $URIParser.unparse(connection)
	var db = connection["db"]
	$PythonWatcher.run(code, uri, db, 20)


func _remove_tree_item(tree_item : TreeItem):
	tree_item.get_parent().remove_child(tree_item)
	tree_item.free()


func _remove_childrens(tree_item : TreeItem):
	while tree_item.get_children():
		_remove_tree_item(tree_item.get_children())
