extends Node


signal new_collections(tree, parent, collections)


func _ready():
	pass


func refresh_database(tree : Tree, tree_item : TreeItem):
	_remove_childrens(tree_item)
	_update_database_collections(tree, tree_item)


func _remove_tree_item(tree_item : TreeItem):
	tree_item.get_parent().remove_child(tree_item)
	tree_item.free()


func _remove_childrens(tree_item : TreeItem):
	while tree_item.get_children():
		_remove_tree_item(tree_item.get_children())


func _update_database_collections(tree : Tree, tree_item : TreeItem):
	var database = tree_item.get_metadata(0)
	var code = "self.db.list_collection_names()"
	var kwargs = {"tree": tree, "tree_item": tree_item}
	
	$PythonWatcher.run(code, database["uri"], database["name"], 20, 0, kwargs)


func _on_PythonWatcher_output(output, kwargs):
	var tree = kwargs.get("tree")
	var parent = kwargs.get("tree_item")
	var collections = _get_output_collections(output)
	
	emit_signal("new_collections", tree, parent, collections)
	
	$PythonWatcher/Python.kill_current_execution()


func _get_output_collections(output : String):
	var python_result = GenericResult.parse_python_output(output)
	
	if python_result.error == OK:
		return python_result["result"]
	
	$Alert.message(python_result.error_string)
	return []


func _on_Connection_new_databases(tree, parent, databases):
	_add_databases(tree, parent, databases)


func _add_databases(tree : Tree, parent : TreeItem, databases : Array):
	var connection = parent.get_metadata(0)
	
	for db in databases:
		_add_database(tree, parent, {
			"__type__": MondotType.DATABASE,
			"uri": URIParser.unparse(connection),
			"name": db,
		})


func _add_database(tree : Tree, parent : TreeItem, database : Dictionary):
	var tree_item = tree.create_item(parent)
	
	tree_item.set_text(0, database["name"])
	tree_item.set_metadata(0, database)
	tree_item.set_icon(0, MondotIcon.from(MondotType.DATABASE))
