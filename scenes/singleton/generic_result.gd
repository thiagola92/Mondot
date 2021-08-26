extends Node


class GenericResult:
	var error
	var error_string
	var result
	
	func _init(_error, _error_string, _result):
		error = _error
		error_string = _error_string
		result = _result


static func new(error : int = OK, error_string : String = "", result = null):
	return GenericResult.new(error, error_string, result)
	
