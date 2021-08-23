extends Node


static func parse(uri : String) -> GenericResult:
	var regex = _get_regex()
	var regex_result = regex.search(uri)
	
	if not regex_result:
		return GenericResult.new(ERR_PARSE_ERROR, "Fail to parse URI. Your URI could be invalid or ours regex wrong")
	
	var parse_result = {
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
	
	if not parse_result["scheme"] in ["mongodb", "mongodb+srv"]:
		return GenericResult.new(ERR_PARSE_ERROR, 'URI scheme must be "mongodb" or "mongodb+srv"')
	
	if not parse_result["username"]:
		parse_result["username"] = null
		
	if not parse_result["password"]:
		parse_result["password"] = null
		
	if not parse_result["host"]:
		return GenericResult.new(ERR_PARSE_ERROR, "Missing host in URI")
	
	if parse_result["port"]:
		parse_result["port"] = int(parse_result["port"])
	
	if not parse_result["port"]:
		parse_result["port"] = 27017
		
	if not parse_result["db"]:
		parse_result["db"] = "admin"
		
	var schema_result = Schema.validate(parse_result, MondotSchema.CONNECTION)
	if schema_result.error != OK:
		return schema_result
	
	return GenericResult.new(OK, "", parse_result)


static func _get_regex() -> RegEx:
	var regex = RegEx.new()
	var pattern = "(?<scheme>mongodb|mongodb\\+srv):\\/\\/((?<username>[^:\\/?#[\\]@]*?)(:(?<password>[^:\\/?#[\\]@]+?))?@)?(?<host>[^:\\/?#[\\]@]*?)(:(?<port>\\d*?))?(\\/(?<db>[^:\\/?#[\\]@]*?))?(\\?(?<options>.*))?$"
	
	regex.compile(pattern)
	
	return regex


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
	if not connection.get("username"):
		return ""
	
	if not connection.get("password"):
		return "%s@" % connection["username"]
		
	return "%s:%s@" % [connection["username"], connection["password"],]
