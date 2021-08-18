extends MenuButton

signal open_connections_list_pressed
signal exit_pressed


func _ready():
	var _error = get_popup().connect("id_pressed", self, "_on_Popup_id_pressed")


func _on_Popup_id_pressed(id : int):
	match id:
		0:
			emit_signal("open_connections_list_pressed")
		1:
			emit_signal("exit_pressed")


func _on_File_exit_pressed():
	get_tree().quit()


func _on_File_open_connections_list_pressed():
	$ConnectionsList.popup_centered()
