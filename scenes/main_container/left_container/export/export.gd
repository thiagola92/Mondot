extends WindowDialog


const label = "Export from %s to"

var source : Dictionary
var connections : Array = []


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()


func from(item : Dictionary, root : TreeItem):
	source = item
	
	_get_connections(root)
	_update_source_label(item)
	_select_connection_path()
	_update_connections_options()
	
	# The user get here using an connection, so at least one exists
	_get_databases(connections[0])
	
	popup_centered()


func _get_connections(root : TreeItem):
	var child = root.get_children()
	
	while child:
		connections.append(child.get_metadata(0))
		child = child.get_next()


func _update_source_label(item : Dictionary):
	$Container/Route/Source.text = label % source["name"]


func _select_connection_path():
	$Container/FolderPath.hide()
	$Container/ConnectionPath.show()


func _update_connections_options():
	for index in range(connections.size()):
		$Container/ConnectionPath/Connection.add_item(
			connections[index]["name"], index
		)


func _get_databases(connection : Dictionary):
	$PythonWatcher.run(
		ClientCode.list_database_names(),
		connection["uri"],
		"admin",
		1000
	)


func _on_Target_item_selected(index):
	_clear_table()
	
	match index:
		0:
			_select_connection_path()
		1:
			_select_folder_path()


func _clear_table():
	$Container/TableBG/Container/Table.clear()


func _select_folder_path():
	$Container/ConnectionPath.hide()
	$Container/FolderPath.show()


func _on_PythonWatcher_output(output, _kwargs):
	output = JSON.parse(output)
	if output.error != OK:
		return
	
	output = output["result"]
	if output["error"] == true:
		return
	
	_update_databases_options(output["result"])


func _update_databases_options(databases : Array):
	for index in range(databases.size()):
		$Container/ConnectionPath/Database.add_item(
			databases[index], index
		)


func _on_Connection_item_selected(index):
	var connection = connections[index]
	
	$Container/ConnectionPath/Database.clear()
	
	_get_databases(connection)


func _on_Export_hide():
	$Container/Route/Target.select(0)
	$Container/ConnectionPath/Connection.clear()
	$Container/ConnectionPath/Database.clear()


func _on_Database_item_selected(index : int):
	_clear_table()
	
	var uri = _get_selected_connection().get("uri")
	var db = _get_selected_database(index)
	var database = _generate_database(uri, db)
	
	match source["__type__"]:
		MondotType.COLLECTION:
			_insert_collection(database, source["name"])
		MondotType.DATABASE:
			_insert_database(database)
		MondotType.CONNECTION:
			pass


func _get_selected_connection() -> Dictionary:
	var id = $Container/ConnectionPath/Connection.get_selected_id()
	var index = $Container/ConnectionPath/Connection.get_item_index(id)
	return connections[index]


func _get_selected_database(index : int) -> String:
	return $Container/ConnectionPath/Database.get_item_text(index)


func _generate_database(uri : String, name : String):
	return {
		"__type__": MondotType.DATABASE,
		"uri": uri,
		"name": name
	}


func _insert_collection(database : Dictionary, collection : String):
	$Container/TableBG/Container/Table.add_line(
		database["name"],
		collection,
		collection
	)


func _insert_database(database : Dictionary):
	pass
