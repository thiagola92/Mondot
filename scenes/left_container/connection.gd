extends Node


signal new_databases(tree, parent, databases)


func _ready():
	pass


func add_connection(tree : Tree, connection : Dictionary):
	var root = tree.get_root()
	var tree_item = tree.create_item(root)
	
	tree_item.set_text(0, connection["name"])
	tree_item.set_metadata(0, connection)
	tree_item.set_icon(0, MondotIcon.from(MondotType.CONNECTION))


func disconnect_connection(tree : Tree, tree_item : TreeItem):
	_remove_tree_item(tree_item)
	tree.update()


func refresh_connection(tree : Tree, tree_item : TreeItem):
	_remove_childrens(tree_item)
	_update_connection_databases(tree, tree_item)


func _remove_tree_item(tree_item : TreeItem):
	tree_item.get_parent().remove_child(tree_item)
	tree_item.free()


func _remove_childrens(tree_item : TreeItem):
	while tree_item.get_children():
		_remove_tree_item(tree_item.get_children())


func _update_connection_databases(tree : Tree, tree_item : TreeItem):
	var connection = tree_item.get_metadata(0)
	var code = "self.client.list_database_names()"
	var kwargs = {"tree": tree, "tree_item": tree_item}
	
	$PythonWatcher.run(code, connection["uri"], "admin", 20, 0, kwargs)


func _on_PythonWatcher_output(output : String, kwargs : Dictionary):
	var tree = kwargs.get("tree")
	var parent = kwargs.get("tree_item")
	var databases = _get_output_databases(output)
	
	emit_signal("new_databases", tree, parent, databases)
	
	$PythonWatcher/Python.kill_current_execution()


func _get_output_databases(output : String):
	var python_result = MondotPython.parse_output(output)
	
	if python_result.error == OK:
		return python_result["result"]
	
	$Alert.message(python_result.error_string)
	return []
