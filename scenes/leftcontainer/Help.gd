extends MenuButton

signal about_pressed

const options = {
	0: "about_pressed"
}


func _ready():
	get_popup().connect("id_pressed", self, "_on_id_pressed")


func _on_id_pressed(id):
	emit_signal(options[id])


func _on_Help_about_pressed():
	$About.popup_centered()
