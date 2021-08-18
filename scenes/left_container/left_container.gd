extends VBoxContainer

signal shell_requested(connection)


func _ready():
	pass


func _on_Tree_open_shell_pressed(connection):
	emit_signal("shell_requested", connection)
