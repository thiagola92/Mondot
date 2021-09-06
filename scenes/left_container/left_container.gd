extends VBoxContainer

signal shell_requested(uri, code, db)
signal process_requested(uri, code, db)


func _ready():
	pass


func _on_Tree_open_shell_pressed(uri, db, code):
	emit_signal("shell_requested", uri, db, code)


func _on_Tree_collection_moved(uri, db, code):
	emit_signal("process_requested", uri, db, code)
