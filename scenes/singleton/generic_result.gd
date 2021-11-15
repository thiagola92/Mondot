extends Node


var error
var error_string
var result


static func new(_error : int = OK, _error_string : String = "", _result = null):
	var clone = GenericResult.duplicate()
	
	clone.error = _error
	clone.error_string = _error_string
	clone.result = _result
	
	return clone
	
