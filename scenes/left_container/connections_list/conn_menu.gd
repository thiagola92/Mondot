extends PopupMenu

signal edit_connection_pressed


func _ready():
	pass


func popup_on_mouse():
	rect_position = get_viewport().get_mouse_position()
	popup()


func _on_ConnMenu_id_pressed(id : int):
	match id:
		0:
			emit_signal("edit_connection_pressed")
