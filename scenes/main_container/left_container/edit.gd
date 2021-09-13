extends MenuButton

signal preferences_pressed
signal theme_pressed


func _ready():
	var _error = get_popup().connect("id_pressed", self, "_on_id_pressed")
	
	
func _on_id_pressed(id : int):
	match id:
		0:
			emit_signal("preferences_pressed")
		1:
			emit_signal("theme_pressed")
