extends VBoxContainer


func _ready():
	pass


func _switch_lock(readonly : bool):
	$Menu/Lock.pressed = readonly
	$CodeEditor.readonly = readonly
	
	match readonly:
		true:
			$Menu/Lock.icon = load(MondotIcon.LOCK)
		false:
			$Menu/Lock.icon = load(MondotIcon.UNLOCK)


func _switch_visibility(hidden : bool):
	$Menu/Visibility.pressed = hidden
	
	match hidden:
		true:
			$Menu/Visibility.icon = load(MondotIcon.VISIBILITY_HIDDEN)
			$CodeEditor.hide()
			$VisibilityWarning.show()
		false:
			$Menu/Visibility.icon = load(MondotIcon.VISIBILITY_VISIBLE)
			$CodeEditor.show()
			$VisibilityWarning.hide()


func _on_Lock_toggled(button_pressed : bool):
	_switch_lock(button_pressed)


func _on_Visibility_toggled(button_pressed):
	_switch_visibility(button_pressed)


func _on_Save_pressed():
	_save_python_code()


func _save_python_code():
	var code = $CodeEditor.text
	$SaveCode.save(code)
