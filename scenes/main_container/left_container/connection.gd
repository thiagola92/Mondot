extends Node


signal new_databases(tree, parent, databases)
signal shell_requested(uri, db, code, readonly)


func _ready():
	pass


func add_connection(tree : Tree, connection : Dictionary):
	var root = tree.get_root()
	var tree_item = tree.create_item(root)
	
	tree_item.set_text(0, connection["name"])
	tree_item.set_metadata(0, connection)
	tree_item.set_icon(0, MondotIcon.from(MondotType.CONNECTION))


func open_shell(uri : String):
	emit_signal("shell_requested", uri, "admin", "")


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
	var code = ClientCode.list_database_names()
	var kwargs = {"tree": tree, "tree_item": tree_item}
	
	$PythonWatcher.run(code, connection["uri"], "admin", 1000, 0, kwargs)


func _on_PythonWatcher_output(result : GenericResult, kwargs : Dictionary):
	var tree = kwargs.get("tree")
	var parent = kwargs.get("tree_item")
	var databases = _get_output_databases(result)
	
	emit_signal("new_databases", tree, parent, databases)
	
	$PythonWatcher.kill_current_execution()


func _get_output_databases(result : GenericResult):
	if result.error == OK:
		return result.result
		
	Alert.message(result.error_string)
	
	return []
