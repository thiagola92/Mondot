extends MenuButton

signal open_connections_list_pressed
signal new_connection_pressed
signal disconnect_pressed
signal exit_pressed

const options = {
	0: "open_connections_list_pressed",
	1: "new_connection_pressed",
	2: "exit_pressed",
}


func _ready():
	get_popup().connect("id_pressed", self, "_on_id_pressed")


func _on_id_pressed(id):
	emit_signal(options[id])


func _on_File_exit_pressed():
	get_tree().quit()
