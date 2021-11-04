extends VBoxContainer


signal shell_requested(uri, code, db, readonly)


func _ready():
	pass


func _on_Connection_shell_requested(uri, db, code, readonly = false, hidden = false):
	emit_signal("shell_requested", uri, db, code, readonly, hidden)


func _on_Database_shell_requested(uri, db, code, readonly = false, hidden = false):
	emit_signal("shell_requested", uri, db, code, readonly, hidden)


func _on_Collection_shell_requested(uri, db, code, readonly = false, hidden = false):
	emit_signal("shell_requested", uri, db, code, readonly, hidden)


func _on_ExportToConn_export_requested(uri, db, code, readonly = true, hidden = true):
	emit_signal("shell_requested", uri, db, code, readonly, hidden)
