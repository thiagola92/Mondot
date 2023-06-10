class_name DatabaseMenu
extends MenuButton


## Emitted when connection is added.
signal connection_added(uris_dbs: Array[Array])

## Emitted when connection is removed.
signal connection_removed(uris_dbs: Array[Array])

## Emitted when user check/uncheck a database.
signal database_checked(uris_dbs: Array[Array])

@onready var menu: PopupMenu = get_popup()


func _ready() -> void:
	menu.hide_on_checkable_item_selection = false
	
	connect_to_connections()


func connect_to_connections() -> void:
	Connections.connection_added.connect(add_connection)
	Connections.connection_removed.connect(remove_connection)


## Add connection to menu and an empty submenu with it.
func add_connection(connection_info: ConnectionInfo) -> void:
	var submenu: PopupMenu = PopupMenu.new()
	submenu.hide_on_checkable_item_selection = false
	submenu.index_pressed.connect(toggle_database.bind(submenu))
	
	menu.add_child(submenu)
	menu.add_submenu_item(connection_info.connection_name, submenu.name)
	menu.set_item_metadata(item_count - 1, connection_info)
	
	connection_info.connection_name_changed.connect(update_connection)
	connection_added.emit(get_uris_dbs())


## Update connection from menu.
func update_connection(connection_info: ConnectionInfo) -> void:
	var index = PopupMenuUtility.get_metadata_index(connection_info, menu)
	menu.set_item_text(index, connection_info.connection_name)


## Remove connection from menu if it's present.
func remove_connection(connection_info: ConnectionInfo) -> void:
	var index = PopupMenuUtility.get_metadata_index(connection_info, menu)
	var submenu = PopupMenuUtility.get_submenu(index, menu)
	
	if index >= 0 and submenu:
		menu.remove_item(index)
		submenu.queue_free()
		connection_removed.emit(get_uris_dbs())


## Set all database for a connection submenu.
func set_databases(databases: Array[String], connection_info: ConnectionInfo) -> void:
	var index: int = PopupMenuUtility.get_metadata_index(connection_info, menu)
	var submenu: PopupMenu = PopupMenuUtility.get_submenu(index, menu)
	
	submenu.clear()
	
	for database in databases:
		submenu.add_check_item(database)


## Toggle a database checkbox.
func toggle_database(index: int, submenu: PopupMenu) -> void:
	submenu.toggle_item_checked(index)
	database_checked.emit(get_uris_dbs())


## Get an [Array] with two elements:
## [br]1- Array of URIs.
## [br]2- Array of databases.
## [br]
## [br]Both Arrays have the same size.
## [br][b]Example[/b]: [code][[uri1, uri2, uri3], [db1, db2, db3]][/code]
func get_uris_dbs() -> Array[Array]:
	var uris: Array[String] = []
	var databases: Array[String] = []
	
	for i in range(menu.item_count):
		var connection_info: ConnectionInfo = menu.get_item_metadata(i) as ConnectionInfo
		var submenu: PopupMenu = PopupMenuUtility.get_submenu(i, menu)
		
		for database in get_databases_checked(submenu):
			uris.append(connection_info.connection_uri)
			databases.append(database)
	
	assert(uris.size() == databases.size())
	
	return [uris, databases]


## Get all databases checked from a connection.
## [br]If no database is checked, it will assume that the user wants
## the default database defined in [PythonArgs].
## [br]
## [br][b]Note[/b]: The database is only used to set the variable [code]self.db[/code]
## on Python code. It doesn't change the database from URI.
func get_databases_checked(submenu: PopupMenu) -> Array[String]:
	var databases: Array[String] = PopupMenuUtility.get_checked_texts(submenu)
	
	if databases.is_empty():
		return [PythonArgs.DEFAULT_DB]
	return databases
