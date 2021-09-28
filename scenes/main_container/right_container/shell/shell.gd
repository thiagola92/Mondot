extends VBoxContainer


var uri : String = "mongodb://127.0.0.1"
var db : String = "admin"


func _ready():
	pass


func setup(_uri : String, _db : String, code : String, readonly : bool):
	self.uri = _uri
	self.db = _db
	
	$CodeEditor.text = code
	
	_switch_lock_icon(readonly)
	_switch_readonly_property(readonly)


func _switch_lock_icon(readonly : bool):
	$Menu/Lock.pressed = readonly
	
	match readonly:
		true:
			$Menu/Lock.icon = load(MondotIcon.LOCK)
		false:
			$Menu/Lock.icon = load(MondotIcon.UNLOCK)


func _switch_readonly_property(readonly : bool):
	$CodeEditor.readonly = readonly


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
	_switch_lock_icon(button_pressed)
	_switch_readonly_property(button_pressed)
