extends VSplitContainer


var uri : String = "mongodb://127.0.0.1"
var db : String = "admin"


func _ready():
	pass


func setup(_uri : String, _db : String, code : String, readonly : bool, hidden : bool):
	self.uri = _uri
	self.db = _db
	
	$ShellCode/CodeEditor.text = code
	
	$ShellCode._switch_lock(readonly)
	$ShellCode._switch_visibility(hidden)


func _on_Run_pressed():
	_clear_previous_output()
	_execute_python_code()
	_show_running_icon()


func _clear_previous_output():
	$ShellOutput.clear()


func _execute_python_code():
	var code = $ShellCode/CodeEditor.text
	var page_size = _get_page_size()
	
	$ShellOutput/PythonWatcher.run(code, uri, db, page_size)
	

func _show_running_icon():
	$ShellOutput/Menu/Running.show()


func _get_page_size() -> int:
	var index = $ShellCode/Menu/PageSize.selected
	var text = $ShellCode/Menu/PageSize.get_item_text(index)
	
	return int(text)


func _on_Stop_pressed():
	_stop_python_code()
	_hide_running_icon()


func _stop_python_code():
	$ShellOutput/PythonWatcher.kill_current_execution()
	

func _hide_running_icon():
	$ShellOutput/Menu/Running.hide()
