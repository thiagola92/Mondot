class_name ConnectionInfo
extends RefCounted


## Emitted when the connection name change.
## [br]
## [br][b]Note[/b]: This is important to Nodes know when to update the connection name.
## Otherwise they would have to check periodically.
signal connection_name_changed(connection_info: ConnectionInfo)

## Emitted when the connection URI change.
signal connection_uri_changed(connection_info: ConnectionInfo)

## Name for the user identify this connection inside the GUI, this have no use in shell.
var connection_name: String:
	set(v):
		connection_name = v
		connection_name_changed.emit(self)

## URI to access the MongoDB.
var connection_uri: String:
	set(v):
		connection_uri = v
		connection_uri_changed.emit(self)


func _init(name: String, uri: String) -> void:
	connection_name = name
	connection_uri = uri


func to_dict() -> Dictionary:
	return {
		"alias": connection_name,
		"uri": connection_uri,
	}
