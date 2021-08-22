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


func refresh_connection(tree : Tree, tree_item : TreeItem):
	_remove_childrens(tree_item)
	_update_connection_databases(tree, tree_item)


func _update_connection_databases(tree : Tree, tree_item : TreeItem):
	var connection = tree_item.get_metadata(0)
	var code = "self.client.list_database_names()"
	var uri = URIParser.unparse(connection)
	var db = connection.get("db", "admin")
	var kwargs = {"tree": tree, "tree_item": tree_item}
	
	$PythonWatcher.run(code, uri, db, 20, 0, kwargs)


func _remove_tree_item(tree_item : TreeItem):
	tree_item.get_parent().remove_child(tree_item)
	tree_item.free()


func _remove_childrens(tree_item : TreeItem):
	while tree_item.get_children():
		_remove_tree_item(tree_item.get_children())


func _on_PythonWatcher_outputted(output, kwargs):
	var parse_result = JSON.parse(output)
	var tree = kwargs["tree"]
	var parent = kwargs["tree_item"]
	var databases = parse_result.result["value"]
	
	if parse_result.result["error"]:
		return $Alert.message("Failed to refresh")
	
	_add_databases(tree, parent, databases)


func _add_databases(tree : Tree, parent : TreeItem, databases : Array):
	for db in databases:
		_add_database(tree, parent, {
			"__type__": MondotType.DATABASE,
			"name": db
		})


func _add_database(tree : Tree, parent : TreeItem, database : Dictionary):
	var tree_item = tree.create_item(parent)
	
	tree_item.set_text(0, database["name"])
	tree_item.set_metadata(0, database)
