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
		"options": regex_result.get_string("options"),
	}
	
	return GenericResult.new(OK, "", connection)


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
