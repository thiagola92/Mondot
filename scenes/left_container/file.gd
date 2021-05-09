extends MenuButton

signal open_connections_list_pressed
signal exit_pressed

const options = {
	0: "open_connections_list_pressed",
	1: "exit_pressed",
}


func _ready():
	get_popup().connect("id_pressed", self, "_on_Popup_id_pressed")


func _on_Popup_id_pressed(id : int):
	emit_signal(options[id])


func _on_File_exit_pressed():
	get_tree().quit()


func _on_File_open_connections_list_pressed():
	$ConnectionsList.popup_centered()
