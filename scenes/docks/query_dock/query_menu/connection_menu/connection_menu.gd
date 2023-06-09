class_name ConnectionMenu
extends MenuButton


@onready var menu: PopupMenu = get_popup()


func _ready() -> void:
	menu.hide_on_checkable_item_selection = false
	menu.index_pressed.connect(check_connection)
	
	connect_to_connections()
	load_connections()


func check_connection(index: int) -> void:
	var checked = menu.is_item_checked(index)
	menu.set_item_checked(index, not checked)


func connect_to_connections() -> void:
	Connections.connection_added.connect(add_connection)
	Connections.connection_removed.connect(remove_connection)


func add_connection(connection_info: ConnectionInfo) -> void:
	menu.add_item(connection_info.connection_name)
	menu.set_item_as_checkable(item_count - 1, true)
	menu.set_item_metadata(item_count - 1, connection_info)
	connection_info.connection_name_changed.connect(update_connection)


func update_connection(connection_info: ConnectionInfo) -> void:
	for i in range(item_count):
		var metadata = menu.get_item_metadata(i)
		
		if metadata == connection_info:
			menu.set_item_text(i, metadata.connection_name)
			break


func remove_connection(connection_info: ConnectionInfo) -> void:
	for i in range(item_count):
		var metadata = menu.get_item_metadata(i)
		
		if metadata == connection_info:
			menu.remove_item(i)
			break


func load_connections() -> void:
	for c in Connections.connections:
		add_connection(c)


func get_checked_connections() -> Array[ConnectionInfo]:
	var connections_info: Array[ConnectionInfo] = []
	
	for i in range(item_count):
		if menu.is_item_checked(i):
			var metadata = menu.get_item_metadata(i)
			
			if metadata is ConnectionInfo:
				connections_info.append(metadata)
	
	return connections_info
