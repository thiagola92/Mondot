class_name ConnectionOption
extends OptionButton


signal connection_selected(connection_info: ConnectionInfo)


func _ready() -> void:
	connect_to_connections()
	load_connections()


func connect_to_connections() -> void:
	Connections.connection_added.connect(add_connection)
	Connections.connection_removed.connect(remove_connection)


func add_connection(connection_info: ConnectionInfo) -> void:
	add_item(connection_info.connection_name)
	set_item_metadata(item_count - 1, connection_info)


func remove_connection(connection_info: ConnectionInfo) -> void:
	for i in range(item_count):
		var metadata = get_item_metadata(i)
		
		if metadata == connection_info:
			remove_item(i)
			break


func load_connections() -> void:
	for c in Connections.connections:
		add_connection(c)


func _on_draw() -> void:
	for i in range(item_count):
		var metadata = get_item_metadata(i)
		
		if metadata is ConnectionInfo:
			set_item_text(i, metadata.connection_name)


func _on_item_selected(index: int) -> void:
	var metadata = get_item_metadata(index)
	
	if metadata is ConnectionInfo:
		connection_selected.emit(metadata)
