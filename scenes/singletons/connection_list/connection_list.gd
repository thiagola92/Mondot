class_name ConnectionList
extends Node


signal connection_added(query_info: ConnectionInfo)

signal connection_removed(query_info: ConnectionInfo)

var connections: Array[ConnectionInfo] = [
		ConnectionInfo.new("localhost", "mongodb://username:password@127.0.0.1"),
		ConnectionInfo.new("production", "mongodb://username:password@127.0.0.1"),
		ConnectionInfo.new("test", "mongodb://username:password@127.0.0.1"),
		ConnectionInfo.new("personal project", "mongodb://username:password@127.0.0.1"),
]


## Import from file every connections informations.
func import() -> void:
	pass


func add_connection(connection_name: String, uri: String) -> void:
	var connection_info: ConnectionInfo = ConnectionInfo.new(connection_name, uri)
	connections.append(connection_info)
	connection_added.emit(connection_info)
	
	export()


func remove_connection(connection_info: ConnectionInfo) -> void:
	connections.erase(connection_info)
	connection_removed.emit(connection_info)
	
	export()


## Export to a file all connections informations.
func export() -> void:
	pass
