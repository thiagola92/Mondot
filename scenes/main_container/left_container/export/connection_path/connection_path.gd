extends HBoxContainer


signal database_selected()


var connections : Array
var databases : Array


func setup(_connections : Array):
	connections = _connections
	
	_load_connections()
	_load_databases(connections[0]) # The user get here using an connection, so at least one exists
	
	show()


func get_selected_database() -> Dictionary:
	return {
		"__type__": MondotType.DATABASE,
		"uri": _get_selected_connection().get("uri"),
		"name": _get_selected_database()
	}


func _load_connections():
	$Connection.clear()
	
	_update_connections_options()


func _update_connections_options():
	for index in range(connections.size()):
		$Connection.add_item(connections[index]["name"], index)


func _load_databases(connection : Dictionary):
	$Database.clear()
	$PythonWatcher.run(
		ClientCode.list_database_names(),
		connection["uri"],
		"admin",
		1000
	)


func _get_selected_connection() -> Dictionary:
	var id = $Connection.get_selected_id()
	var index = $Connection.get_item_index(id)
	return connections[index]


func _get_selected_database() -> String:
	var id = $Database.get_selected_id()
	var index = $Database.get_item_index(id)
	return databases[index]


func _on_PythonWatcher_output(output, _kwargs):
	output = JSON.parse(output)
	if output.error != OK:
		return
	
	output = output["result"]
	if output["error"] == true:
		return
	
	databases = output["result"]
	
	_update_databases_options()
	_select_first_database()


func _update_databases_options():
	for index in range(databases.size()):
		$Database.add_item(databases[index], index)


func _select_first_database():
	if databases.size() > 0:
		emit_signal("database_selected")


func _on_Connection_item_selected(index : int):
	$Database.clear()
	
	_load_databases(connections[index])


func _on_Database_item_selected(_index : int):
	emit_signal("database_selected")


func _on_ConnectionPath_hide():
	$Connection.clear()
	$Database.clear()
