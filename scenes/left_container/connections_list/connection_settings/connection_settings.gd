extends WindowDialog

signal save_pressed


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		set_connection({
			"name": "Test",
			"uri": "mongodb://127.0.0.1:27017"
		})
		
		popup_centered()
		

func set_connection(connection : Dictionary):
	var parse_result = URIParser.parse(connection["uri"])
	
	if parse_result.error != OK:
		return $Alert.message(parse_result.error_string)
	
	_set_fields(connection["name"], parse_result.result)


func _set_fields(name : String, connection : Dictionary):
	var scheme = connection.get("scheme", "mongodb")
	var host = connection.get("host", "127.0.0.1")
	var port = connection.get("port", "27017")
	var username = connection.get("username", "")
	var password = connection.get("password", "")
	var db = connection.get("db", "admin")
	
	$Container/Organization/NameInput.text = name
	$Container/Settings.set_basic(host, port)
	$Container/Settings.set_authentication(username, password, db)
	$Container/Settings.set_ssl(scheme)


func _on_Cancel_pressed():
	hide()


func _on_Save_pressed():
	var connection = _get_connection()
	emit_signal("save_pressed", connection)
	hide()


func _get_connection() -> Dictionary:
	var connection = {
		"scheme": $Container/Settings.get_scheme(),
		"host": $Container/Settings.get_host(),
		"port": $Container/Settings.get_port(),
		"username": $Container/Settings.get_username(),
		"password": $Container/Settings.get_password(),
		"db": $Container/Settings.get_db(),
	}
	
	return {
		"__type__": MondotType.CONNECTION,
		"name": $Container/Organization/NameInput.text,
		"uri": URIParser.unparse(connection)
	}


func _on_TestConnection_pressed():
	var connection = _get_connection()
	$Container/Actions/Ping.test_connection(connection)


func _on_Input_changed(_a = ""):
	var connection = _get_connection()
	$Container/Result/URI.text = connection["uri"]


func _on_ConnectionSettings_about_to_show():
	var connection = _get_connection()
	$Container/Result.set_uri(connection["uri"])
	$Container/Result.hide_uri()
