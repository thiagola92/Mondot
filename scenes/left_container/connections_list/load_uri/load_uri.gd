extends WindowDialog

signal load_pressed(uri)


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()


func _get_uri() -> String:
	return $VBoxContainer/UriInput.text


func _on_Popup_popup_hide():
	queue_free()


func _on_Cancel_pressed():
	queue_free()


func _on_Load_pressed():
	emit_signal("load_pressed", _get_uri())
	queue_free()
