extends Reference

var error = OK setget set_error, get_error
var error_string = '' setget set_error_string, get_error_string
var result = {} setget set_result, get_result


func _init(connection : Dictionary):
	result = connection.duplicate(true)


func set_error(value : int) -> void:
	error = value


func get_error() -> int:
	return error


func set_error_string(value : String) -> void:
	error_string = value


func get_error_string() -> String:
	return error_string


func set_result(value : Dictionary) -> void:
	result = value


func get_result() -> Dictionary:
	return result
