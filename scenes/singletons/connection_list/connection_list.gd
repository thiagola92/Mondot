class_name ConnectionList
extends Node


signal connection_added(query_info: ConnectionInfo)

signal connection_removed(query_info: ConnectionInfo)

var connections: Array[ConnectionInfo] = []

## Password to connections file.[br]
## Temporary way to give some security.
var password: String = "7102859a71b1e6bcda160ace30a5c5d1"


func _ready() -> void:
	import()


## Import from file every connections informations.
func import() -> void:
	var file: FileAccess = FileAccess.open_encrypted_with_pass("user://connections", FileAccess.READ, password)
	
	if not file:
		return
	
	var content: Variant = JSON.parse_string(file.get_as_text())
	
	if content == null:
		return print("Fail to parse content in connections file")
	
	for c in content:
		add_connection(c["alias"], c["uri"])


func add_connection(connection_name: String, uri: String) -> void:
	var connection_info: ConnectionInfo = ConnectionInfo.new(connection_name, uri)
	connections.append(connection_info)
	connection_added.emit(connection_info)
	
	connection_info.connection_name_changed.connect(func(_c): export())
	connection_info.connection_uri_changed.connect(func(_c): export())
	
	export()


func remove_connection(connection_info: ConnectionInfo) -> void:
	connections.erase(connection_info)
	connection_removed.emit(connection_info)
	
	export()


## Export to a file all connections informations.
func export() -> void:
	var all_connections: Array = []
	
	for c in connections:
		all_connections.append(c.to_dict())
	
	var file: FileAccess = FileAccess.open_encrypted_with_pass("user://connections", FileAccess.WRITE, password)
	var content: String = JSON.stringify(all_connections, "  ")
	
	file.store_string(content)


func _on_tree_exiting() -> void:
	export()
