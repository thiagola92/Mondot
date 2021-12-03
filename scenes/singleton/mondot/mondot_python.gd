extends Node


# Parsing MondotShell output includes two steps:
# - Parse the JSON output
# - Check if an error was raised
static func parse_output(output : String) -> GenericResult:
	var json_result = JSON.parse(output)
		
	if json_result.error:
		return GenericResult.new(json_result.error, json_result.error_string)
	
	var output_result = json_result.result
	
	if output_result["error"]:
		if len(output_result["result"]) > 0:
			return GenericResult.new(output_result["error"], output_result["result"][0])
		return GenericResult.new(output_result["error"])
	
	return GenericResult.new(OK, "", output_result["result"])
