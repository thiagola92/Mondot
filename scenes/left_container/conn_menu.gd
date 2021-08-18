extends PopupMenu

signal open_shell_pressed
signal open_settings_pressed
signal create_database_pressed
signal refresh_pressed
signal disconnect_pressed


func _ready():
	pass


func popup_on_mouse():
	rect_position = get_viewport().get_mouse_position()
	popup()


func _on_Menu_id_pressed(id : int):
	match id:
		0:
			emit_signal("open_shell_pressed")
		1:
			emit_signal("open_settings_pressed")
		2:
			emit_signal("create_database_pressed")
		3:
			emit_signal("refresh_pressed")
		4:
			emit_signal("disconnect_pressed")
