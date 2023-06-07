class_name ConnectionInfo
extends RefCounted


var connection_name: String

var connection_uri: String


func _init(name: String, uri: String):
	connection_name = name
	connection_uri = uri


func to_dict() -> Dictionary:
	return {
		"name": connection_name,
		"uri": connection_uri,
	}
