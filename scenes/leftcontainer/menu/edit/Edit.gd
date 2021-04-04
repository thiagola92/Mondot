extends MenuButton

signal create_database_pressed
signal create_collection_pressed
signal preferences_pressed

const options = {
	0: "preferences_pressed",
	1: "theme_pressed",
}


func _ready():
	get_popup().connect("id_pressed", self, "_on_id_pressed")
	
	
func _on_id_pressed(id):
	emit_signal(options[id])
