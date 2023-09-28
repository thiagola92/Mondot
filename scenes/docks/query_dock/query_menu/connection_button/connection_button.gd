class_name ConnectionButton
extends Button


signal changed()

## A new [PythonOnetime] scene is necessary for each request to database.
## [br][br]
## Reusing the same scene is not an option, as the user could cancel
## the previous request by requesting a new one.
const PythonOnetimeScene: PackedScene = preload("res://scenes/python/python_onetime/python_onetime.tscn")

## A new [PopupCheckable] scene is necessary for each database/collection option.
const PopupCheckablesScene: PackedScene = preload("res://scenes/docks/query_dock/query_menu/connection_button/popup_checkables/popup_checkables.tscn")

@export var connections_popup: PopupCheckables

@export var python_parser: PythonParser

var connections_paths: Array[ConnectionPath] = []


func _ready() -> void:
	add_connections()


func add_connections() -> void:
	Connections.connection_added.connect(add_connection)
	Connections.connection_removed.connect(remove_connection)
	
	for connection in Connections.connections:
		add_connection(connection)


func add_connection(connection_info: ConnectionInfo) -> void:
	var connection_path: ConnectionPath = ConnectionPath.new(connection_info)
	var checkable_menu: CheckableMenu = connections_popup.create_checkable_menu(
		connection_info.connection_name
	)
	
	checkable_menu.set_meta("connection_info", connection_info)
	checkable_menu.set_meta("connection_path", connection_path)
	checkable_menu.checked.connect(request_databases.bind(connection_info))
	checkable_menu.checked.connect(update_connections_paths)
	checkable_menu.unchecked.connect(update_connections_paths)


func remove_connection(connection_info: ConnectionInfo) -> void:
	var checkable: Node = connections_popup.find_checkable_menu_with_metadata("connection_info", connection_info)
	
	if checkable == null:
		return
	
	checkable.queue_free()


func request_databases(connection_info: ConnectionInfo) -> void:
	var python_onetime: PythonOnetime = PythonOnetimeScene.instantiate()
	var args: PythonArgs = PythonArgs.new()
	
	add_child(python_onetime)
	
	args.uris = [connection_info.connection_uri]
	args.dbs = [PythonArgs.DEFAULT_DB]
	
	python_onetime.execution_finished.connect(parse_databases.bind(python_onetime, connection_info))
	python_onetime.run("self.client.list_database_names()", args)


func parse_databases(content: String, python_onetime: PythonOnetime, connection_info: ConnectionInfo) -> void:
	var databases = python_parser.parse_now(content)
	
	python_onetime.queue_free()
	
	if databases == null:
		return
	
	add_databases(databases as Array, connection_info)


func add_databases(databases: Array, connection_info: ConnectionInfo) -> void:
	var checkable_menu: CheckableMenu = connections_popup.find_checkable_menu_with_metadata("connection_info", connection_info)
	
	if checkable_menu == null:
		return
	
	var databases_popup: PopupCheckables = PopupCheckablesScene.instantiate() as PopupCheckables
	
	checkable_menu.set_menu(databases_popup)
#
	for database in databases:
		add_database(databases_popup, connection_info, database)


func add_database(databases_popup: PopupCheckables, connection_info: ConnectionInfo, database: String) -> void:
	var connection_path: ConnectionPath = ConnectionPath.new(connection_info, database)
	var checkable_menu: CheckableMenu = databases_popup.create_checkable_menu(database)
	
	checkable_menu.set_meta("connection_path", connection_path)
	checkable_menu.checked.connect(request_collections.bind(connection_path))
	checkable_menu.checked.connect(update_connections_paths)
	checkable_menu.unchecked.connect(update_connections_paths)


func request_collections(connection_path: ConnectionPath) -> void:
	var python_onetime: PythonOnetime = PythonOnetimeScene.instantiate()
	var args: PythonArgs = PythonArgs.new()
	
	add_child(python_onetime)
	
	args.uris = [connection_path.connection_info.connection_uri]
	args.dbs = [connection_path.database]
	
	python_onetime.execution_finished.connect(parse_collections.bind(python_onetime, connection_path))
	python_onetime.run("self.db.list_collection_names()", args)


func parse_collections(content: String, python_onetime: PythonOnetime, connection_path: ConnectionPath) -> void:
	var collections = python_parser.parse_now(content)
	
	python_onetime.queue_free()
	
	if collections == null:
		return
	
	add_collections(collections as Array, connection_path)


func add_collections(collections: Array, connection_path: ConnectionPath) -> void:
	var conn_checkable_menu: CheckableMenu = connections_popup.find_checkable_menu_with_metadata("connection_info", connection_path.connection_info)
	
	if conn_checkable_menu == null:
		return
	
	var databases_popup: PopupCheckables = conn_checkable_menu.menu as PopupCheckables
	var db_checkable_menu: CheckableMenu = databases_popup.find_checkable_menu_with_text(connection_path.database)
	
	if db_checkable_menu == null:
		return
		
	var collections_popup: PopupCheckables = PopupCheckablesScene.instantiate() as PopupCheckables
	
	db_checkable_menu.set_menu(collections_popup)
	
	for collection in collections:
		add_collection(collections_popup, connection_path, collection)


func add_collection(collections_popup: PopupCheckables, path: ConnectionPath, collection: String) -> void:
	var connection_path: ConnectionPath = ConnectionPath.new(path.connection_info, path.database, collection)
	var checkable_label: CheckableLabel = collections_popup.create_checkable_label(collection)
	
	checkable_label.set_meta("connection_path", connection_path)
	checkable_label.checked.connect(update_connections_paths)
	checkable_label.unchecked.connect(update_connections_paths)


## Use recursion to get [ConnectionPath]s at the tree edge.
func get_connections_paths(popup_checkables: PopupCheckables = connections_popup) -> Array[ConnectionPath]:
	var paths: Array[ConnectionPath] = []
	
	for child in popup_checkables.get_checked_children():
		if child is CheckableLabel:
			paths.append(child.get_meta("connection_path"))
		
		if child is CheckableMenu:
			var child_paths: Array[ConnectionPath] = []
			
			# Menu may not have been created yet.
			if child.menu:
				child_paths.append_array(get_connections_paths(child.menu))
			
			# No child was checked.
			if child_paths.is_empty():
				if child.has_meta("connection_path"):
					child_paths.append(child.get_meta("connection_path"))
			
			paths.append_array(child_paths)
	
	return paths


func update_connections_paths() -> void:
	connections_paths = get_connections_paths()
	changed.emit()


func _on_pressed() -> void:
	connections_popup.popup_on_position(Vector2(global_position.x, global_position.y + size.y))
