extends Node


signal new_collections(tree, parent, collections)
signal shell_requested(uri, db, code, readonly)


func _ready():
	pass


func open_shell(uri : String, db : String):
	emit_signal("shell_requested", uri, db, "")


func refresh_database(tree : Tree, tree_item : TreeItem):
	_remove_childrens(tree_item)
	_update_database_collections(tree, tree_item)


func drop_database(uri : String, db : String):
	var code = MondotBeautifier.beautify_code([
		ClientCode.drop_database(db)
	])
	
	emit_signal("shell_requested", uri, db, code, true)


func _remove_tree_item(tree_item : TreeItem):
	tree_item.get_parent().remove_child(tree_item)
	tree_item.free()


func _remove_childrens(tree_item : TreeItem):
	while tree_item.get_children():
		_remove_tree_item(tree_item.get_children())


func _update_database_collections(tree : Tree, tree_item : TreeItem):
	var database = tree_item.get_metadata(0)
	var code = DatabaseCode.list_collection_names()
	var kwargs = {"tree": tree, "tree_item": tree_item}
	
	$PythonWatcher.run(code, database["uri"], database["name"], 1000, 0, kwargs)


func _on_PythonWatcher_output(result : GenericResult, kwargs : Dictionary):
	var tree = kwargs.get("tree")
	var parent = kwargs.get("tree_item")
	var collections = _get_output_collections(result)
	
	emit_signal("new_collections", tree, parent, collections)
	
	$PythonWatcher.kill_current_execution()


func _get_output_collections(result : GenericResult):
	if result.error == OK:
		return result.result
		
	Alert.message(result.error_string)
	
	return []


func _on_Connection_new_databases(tree, parent, databases):
	_add_databases(tree, parent, databases)


func _add_databases(tree : Tree, parent : TreeItem, databases : Array):
	var connection = parent.get_metadata(0)
	
	for db in databases:
		_add_database(tree, parent, {
			"__type__": MondotType.DATABASE,
			"name": db,
			"uri": connection["uri"],
		})


func _add_database(tree : Tree, parent : TreeItem, database : Dictionary):
	var tree_item = tree.create_item(parent)
	
	tree_item.set_text(0, database["name"])
	tree_item.set_metadata(0, database)
	tree_item.set_icon(0, MondotIcon.from(MondotType.DATABASE))
