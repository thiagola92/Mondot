extends VBoxContainer

signal shell_requested(connection, code)


func _ready():
	pass


func _on_Tree_open_shell_pressed(connection, code):
	emit_signal("shell_requested", connection, code)
