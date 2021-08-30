extends Node


static func parse(uri : String) -> GenericResult:
	var regex = _get_regex()
	var regex_result = regex.search(uri)
	
	if not regex_result:
		return GenericResult.new(FAILED, "Failed to parse URI")
	
	var connection = {
		"scheme": regex_result.get_string("scheme"),
		"username": regex_result.get_string("username"),
		"password": regex_result.get_string("password"),
		"host": regex_result.get_string("host"),
		"port": regex_result.get_string("port"),
		"db": regex_result.get_string("db"),
		"options": _parse_options(regex_result.get_string("options")),
	}
	
	return GenericResult.new(OK, "", connection)


static func _get_regex() -> RegEx:
	var regex = RegEx.new()
	var pattern = "(?<scheme>mongodb|mongodb\\+srv):\\/\\/((?<username>[^:\\/?#[\\]@]*?)(:(?<password>[^:\\/?#[\\]@]+?))?@)?(?<host>[^:\\/?#[\\]@]*?)(:(?<port>\\d*?))?(\\/(?<db>[^:\\/?#[\\]@]*?))?(\\?(?<options>.*))?$"
	
	regex.compile(pattern)
	
	return regex


static func _parse_options(string : String) -> Dictionary:
	var options = {}
	
	for key_value in string.split("&", false):
		key_value = key_value.split("=", false)
		options[key_value[0]] = key_value[1]
	
	return options


static func unparse(connection : Dictionary) -> String:
	return "%s://%s%s:%s/%s?%s" % [
		connection.get("scheme", "mongodb"),
		_unparse_userinfo(connection),
		connection.get("host", "127.0.0.1"),
		connection.get("port", "27017"),
		connection.get("db", "admin"),
		_unparse_options(connection.get("options", {}))
	]


static func _unparse_userinfo(connection : Dictionary) -> String:
	if not connection.get("username"):
		return ""
	
	if not connection.get("password"):
		return "%s@" % connection["username"]
		
	return "%s:%s@" % [connection["username"], connection["password"],]

static func _unparse_options(options : Dictionary) -> String:
	var string = ""
	
	for key in options.keys():
		var value = options[key]
		
		string += "%s=%s" % [key, value]
	
	return string
