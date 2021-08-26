extends Node


static func parse_output(output : String) -> GenericResult:
	var parse_result = JSON.parse(output)
	
	if parse_result.error != OK:
		return GenericResult.new(parse_result.error, parse_result.error_string)
	
	var result = parse_result.result
	
	if result["error"]:
		if len(result["result"]) > 0:
			return GenericResult.new(FAILED, result["result"][0])
		return GenericResult.new(FAILED)
	
	return GenericResult.new(OK, "", result["result"])
