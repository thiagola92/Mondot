extends WindowDialog

signal save_pressed


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()
		

func set_connection(connection : Dictionary):
	$Container/Organization/NameInput.text = connection.get("name")
	$Container/Settings/Basic/HostContainer/HostInput.text = connection.get("host", "127.0.0.1")
	$Container/Settings/Basic/PortContainer/PortInput.text = str(connection.get("port", 27017))


func _on_Cancel_pressed():
	hide()


func _on_Save_pressed():
	emit_signal("save_pressed", _get_connection())
	hide()


func _get_connection() -> Dictionary:
	return {
		"__type__": MondotType.CONNECTION,
		"name": $Container/Organization/NameInput.text,
		"folder": $Container/Organization/FolderInput.selected,
		"host": $Container/Settings/Basic/HostContainer/HostInput.text,
		"port": $Container/Settings/Basic/PortContainer/PortInput.text,
	}

