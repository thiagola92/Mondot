extends VBoxContainer


var uri : String = "mongodb://127.0.0.1"
var db : String = "admin"


func _ready():
	pass


func setup(_uri : String, _db : String, code : String):
	self.uri = _uri
	self.db = _db
	
	$CodeEditor.text = code


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
