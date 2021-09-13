extends WindowDialog

signal loaded(connection)


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()


func _on_Load_pressed():
	_load_uri($Container/UriInput.text)


func _load_uri(uri : String):
	var parse_result = URIParser.parse(uri)
	
	if parse_result.error != OK:
		return $Alert.message(parse_result.error_string)

	emit_signal("loaded", {
		"__type__": MondotType.CONNECTION,
		"name": "New connection",
		"uri": uri,
	})
	
	hide()


func _on_Cancel_pressed():
	hide()
