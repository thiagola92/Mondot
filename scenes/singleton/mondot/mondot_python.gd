extends Node


static func pretty_output(output : String) -> String:
	var parse_result = parse_output(output)
	
	if parse_result.error != OK:
		return '"%s"' % parse_result.error_string
	
	return JSON.print(parse_result.result, "	")


static func parse_output(output : String) -> GenericResult:
	var json_result = JSON.parse(output)
		
	if json_result.error != OK:
		return GenericResult.new(OK, "", output)
	
	var output_result = json_result.result
	
	if output_result["error"]:
		if len(output_result["result"]) > 0:
			return GenericResult.new(FAILED, output_result["result"][0])
		return GenericResult.new(FAILED)
	
	return GenericResult.new(OK, "", output_result["result"])
