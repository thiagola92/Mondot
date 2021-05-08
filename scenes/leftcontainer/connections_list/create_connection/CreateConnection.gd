extends WindowDialog

signal popup_closed


func _ready():
	# For test purpose only
	if get_tree().get_root().get_child(0) == $".":
		popup_centered()


func _on_Cancel_pressed():
	queue_free()


func _on_CreateConnection_popup_hide():
	queue_free()
