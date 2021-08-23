extends Node


class GenericResult:
	func _init(error, error_string, result):
		self.error = error
		self.error_string = error_string
		self.result = result


static func parse_python_output(output : String):
	var parse_result = JSON.parse(output)
	
	if parse_result.error != OK:
		return new(parse_result.error, parse_result.error_string)
	
	var result = parse_result.result
	
	if result["error"]:
		if len(result["result"]) > 0:
			return new(FAILED, result["result"][0])
		return new(FAILED)
	
	return new(OK, "", result["result"])


static func new(error : int = OK, error_string : String = "", result = null):
	return GenericResult.new(error, error_string, result)
	
