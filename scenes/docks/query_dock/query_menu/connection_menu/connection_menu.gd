class_name ConnectionMenu
extends MenuButton


## Emitted after user check a connection.
signal connection_checked(connection_info: ConnectionInfo)

## Emitted after user uncheck a connection.
signal connection_unchecked(connection_info: ConnectionInfo)

@onready var menu: PopupMenu = get_popup()


func _ready() -> void:
	menu.hide_on_checkable_item_selection = false
	menu.index_pressed.connect(toggle_connection)
	
	connect_to_connections()
	load_connections()


func toggle_connection(index: int) -> void:
	menu.toggle_item_checked(index)
	
	if menu.is_item_checked(index):
		connection_checked.emit(menu.get_item_metadata(index))
	else:
		connection_unchecked.emit(menu.get_item_metadata(index))


func connect_to_connections() -> void:
	Connections.connection_added.connect(add_connection)
	Connections.connection_removed.connect(remove_connection)


func add_connection(connection_info: ConnectionInfo) -> void:
	menu.add_item(connection_info.connection_name)
	menu.set_item_as_checkable(item_count - 1, true)
	menu.set_item_metadata(item_count - 1, connection_info)
	
	connection_info.connection_name_changed.connect(update_connection)


func update_connection(connection_info: ConnectionInfo) -> void:
	var index = PopupMenuUtility.get_metadata_index(connection_info, menu)
	menu.set_item_text(index, connection_info.connection_name)


func remove_connection(connection_info: ConnectionInfo) -> void:
	var index = PopupMenuUtility.get_metadata_index(connection_info, menu)
	menu.remove_item(index)


func load_connections() -> void:
	for c in Connections.connections:
		add_connection(c)
