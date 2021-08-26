extends VBoxContainer

signal shell_requested(uri, code, db)


func _ready():
	pass


func _on_Tree_open_shell_pressed(uri, code, db):
	emit_signal("shell_requested", uri, code, db)
