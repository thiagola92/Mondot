extends VBoxContainer


signal shell_requested(uri, code, db, readonly)


func _ready():
	pass


func _on_Connection_shell_requested(uri, db, code, readonly = false):
	emit_signal("shell_requested", uri, db, code, readonly)


func _on_Database_shell_requested(uri, db, code, readonly = false):
	emit_signal("shell_requested", uri, db, code, readonly)


func _on_Collection_shell_requested(uri, db, code, readonly = false):
	emit_signal("shell_requested", uri, db, code, readonly)
