extends PopupMenu

signal open_shell_pressed
signal open_settings_pressed
signal create_database_pressed
signal refresh_pressed
signal disconnect_pressed

const options = {
	0: "open_shell_pressed",
	1: "open_settings_pressed",
	2: "create_database_pressed",
	3: "refresh_pressed",
	4: "disconnect_pressed",
}


func _ready():
	pass


func _on_ConnectionMenu_id_pressed(id):
	emit_signal(options[id])
