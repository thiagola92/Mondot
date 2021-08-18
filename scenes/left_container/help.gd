extends MenuButton

signal about_pressed


func _ready():
	var _error = get_popup().connect("id_pressed", self, "_on_id_pressed")


func _on_id_pressed(id : int):
	match id:
		0:
			emit_signal("about_pressed")


func _on_Help_about_pressed():
	$About.popup_centered()
