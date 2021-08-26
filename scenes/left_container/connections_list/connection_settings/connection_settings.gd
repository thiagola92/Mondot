extends WindowDialog

signal save_pressed


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		set_connection({})
		popup_centered()
		

func set_connection(connection : Dictionary):
	var parse_result = URIParser.parse(connection["uri"])
	
	if parse_result.error != OK:
		return $Alert.message(parse_result.error_string)
	
	_set_fields(connection["name"], parse_result.result)


func _set_fields(name : String, connection : Dictionary):
	$Container/Organization/NameInput.text = name
	$Container/Settings/Basic/HostContainer/HostInput.text = connection.get("host", "127.0.0.1")
	$Container/Settings/Basic/PortContainer/PortInput.text = connection.get("port", "27017")
	$Container/Settings/Authentication/DatabaseContainer/DatabaseInput.text = connection.get("db", "admin")


func _on_Cancel_pressed():
	hide()


func _on_Save_pressed():
	var connection = _get_connection()
	emit_signal("save_pressed", connection)
	hide()


func _get_connection() -> Dictionary:
	return {
		"__type__": MondotType.CONNECTION,
		"name": $Container/Organization/NameInput.text,
		"uri": URIParser.unparse({
			"host": $Container/Settings/Basic/HostContainer/HostInput.text,
			"port": $Container/Settings/Basic/PortContainer/PortInput.text,
			"db": $Container/Settings/Authentication/DatabaseContainer/DatabaseInput.text,
		})
	}



func _on_TestConnection_pressed():
	var connection = _get_connection()
	$Container/Actions/Ping.test_connection(connection)
