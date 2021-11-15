extends Node


var error
var error_string
var result


# Don't call this class directly, instead use the function "new"
# Example: GenericResult.new(error, error_string, result)
#class GenericResult:
#	var error
#	var error_string
#	var result
#
#	func _init(_error, _error_string, _result):
#		error = _error
#		error_string = _error_string
#		result = _result


static func new(error : int = OK, error_string : String = "", result = null):
	var clone = GenericResult.duplicate()
	
	clone.error = error
	clone.error_string = error_string
	clone.result = result
	
	return clone
	
