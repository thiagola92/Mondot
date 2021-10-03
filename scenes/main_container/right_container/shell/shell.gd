extends VBoxContainer


var uri : String = "mongodb://127.0.0.1"
var db : String = "admin"


func _ready():
	pass


func setup(_uri : String, _db : String, code : String, readonly : bool, hidden : bool):
	self.uri = _uri
	self.db = _db
	
	$CodeEditor.text = code
	
	_switch_lock(readonly)
	_switch_visibility(hidden)


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


func _on_Run_pressed():
	_clear_previous_output()
	_execute_python_code()


func _clear_previous_output():
	$ShellOutput.clear()


func _execute_python_code():
	var code = $CodeEditor.text
	var page_size = _get_page_size()
	
	$ShellOutput/PythonWatcher.run(code, uri, db, page_size)


func _get_page_size() -> int:
	var index = $Menu/PageSize.selected
	var text = $Menu/PageSize.get_item_text(index)
	
	return int(text)


func _on_Lock_toggled(button_pressed : bool):
	_switch_lock(button_pressed)


func _on_Visibility_toggled(button_pressed):
	_switch_visibility(button_pressed)


func _on_Stop_pressed():
	_stop_python_code()


func _stop_python_code():
	$ShellOutput/PythonWatcher.kill_current_execution()


func _on_Save_pressed():
	var code = $CodeEditor.text
	$SaveCode.save(code)
