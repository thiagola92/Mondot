extends Node


static func parse(uri : String) -> GenericResult:
	var regex = _get_regex()
	var regex_result = regex.search(uri)
	
	if not regex_result:
		return _get_parse_error("Fail to parse URI. Your URI could be invalid or ours regex wrong")
	
	var parser_result = {
		"__type__": MondotType.CONNECTION,
		"name": "New connection",
		"scheme": regex_result.get_string("scheme"),
		"username": regex_result.get_string("username"),
		"password": regex_result.get_string("password"),
		"host": regex_result.get_string("host"),
		"port": regex_result.get_string("port"),
		"db": regex_result.get_string("db"),
		"options": regex_result.get_string("options"),
	}
	
	if not parser_result["scheme"] in ["mongodb", "mongodb+srv"]:
		return _get_parse_error('URI scheme must be "mongodb" or "mongodb+srv"')
	
	if not parser_result["username"]:
		parser_result["username"] = null
		
	if not parser_result["password"]:
		parser_result["password"] = null
		
	if not parser_result["host"]:
		return _get_parse_error('Missing host in URI')
	
	if parser_result["port"]:
		parser_result["port"] = int(parser_result["port"])
	
	if not parser_result["port"]:
		parser_result["port"] = 27017
		
	if not parser_result["db"]:
		parser_result["db"] = "admin"
		
	var schema_result = Schema.validate(parser_result, MondotSchema.CONNECTION)
	if schema_result.error != OK:
		return schema_result
	
	return _get_parse_success(parser_result)


static func _get_regex():
	var regex = RegEx.new()
	var pattern = "(?<scheme>mongodb|mongodb\\+srv):\\/\\/((?<username>[^:\\/?#[\\]@]*?)(:(?<password>[^:\\/?#[\\]@]+?))?@)?(?<host>[^:\\/?#[\\]@]*?)(:(?<port>\\d*?))?(\\/(?<db>[^:\\/?#[\\]@]*?))?(\\?(?<options>.*))?$"
	
	regex.compile(pattern)
	
	return regex


static func _get_parse_error(error_string : String) -> GenericResult:
	var generic_result = GenericResult.duplicate()
	generic_result.error_string = error_string
	generic_result.error = ERR_PARSE_ERROR
	
	return generic_result


static func _get_parse_success(parser_result : Dictionary) -> GenericResult:
	var generic_result = GenericResult.duplicate()
	generic_result.result = parser_result
	
	return generic_result


static func unparse(connection : Dictionary) -> String:
	return "%s://%s%s:%s/%s?%s" % [
		connection.get("scheme", "mongodb"),
		_unparse_userinfo(connection),
		connection.get("host", "127.0.0.1"),
		connection.get("port", 27017),
		connection.get("db", "admin"),
		connection.get("options", "")
	]


static func _unparse_userinfo(connection : Dictionary) -> String:
	if not "username" in connection.keys():
		return ""
	
	if not "password" in connection.keys():
		return "%s@" % connection["username"]
		
	return "%s:%s@" % [connection["username"], connection["password"],]