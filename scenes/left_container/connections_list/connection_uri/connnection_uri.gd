extends WindowDialog

signal loaded(connection)


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()


func _on_Load_pressed():
	_load_uri($Container/UriInput.text)


func _load_uri(uri : String):
	var parser_result = $URIParser.parse(uri)
	
	if parser_result.error != OK:
		return $Alert.message(parser_result.error_string)

	print(parser_result.result)
	emit_signal("loaded", parser_result.result)
	hide()


func _on_Cancel_pressed():
	hide()
