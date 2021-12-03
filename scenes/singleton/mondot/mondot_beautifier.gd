extends Node


# Extract the JSON string or the message error from the MondotShell result
static func beautify_result(parse_result : GenericResult) -> String:
	if parse_result.error:
		return parse_result.error_string
	return JSON.print(parse_result.result, "	")


# Join many codes together giving the proper division
static func beautify_code(codes : Array) -> String:
	var final_code = ""
	
	for code in codes:
		final_code += code.lstrip("\n")
		final_code += "\n"
	
	return final_code
