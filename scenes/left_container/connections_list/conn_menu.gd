extends PopupMenu


func _ready():
	pass


func popup_on_mouse():
	rect_position = get_viewport().get_mouse_position()
	popup()
