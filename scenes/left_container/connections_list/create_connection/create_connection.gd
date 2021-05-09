extends WindowDialog

signal save_pressed


func _ready():
	# For test purpose only
	if get_tree().get_root().get_child(0) == $".":
		popup_centered()


func _get_connection() -> Dictionary:
	return {
		"name": $Container/OrganizationSettings.get_name(),
		"folder": $Container/OrganizationSettings.get_folder(),
		"host": $Container/ConnectionSettings.get_host(),
		"port": $Container/ConnectionSettings.get_port(),
	}


func _on_Cancel_pressed():
	queue_free()


func _on_CreateConnection_popup_hide():
	queue_free()


func _on_Save_pressed():
	queue_free()

