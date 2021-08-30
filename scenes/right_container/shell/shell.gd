extends VBoxContainer


var uri : String
var db : String


func _ready():
	pass


func setup(_uri : String, code : String, _db : String):
	self.uri = _uri
	self.db = _db
	
	$TextEditor.text = code


func _on_Run_pressed():
	_execute_python_code()


func _execute_python_code():
	var code = $TextEditor.text
	var page_size = _get_page_size()
	$ShellOutput/Python.run(code, uri, db, page_size)
	$ShellOutput.start()


func _get_page_size() -> int:
	var index = $Menu/PageSize.selected
	var text = $Menu/PageSize.get_item_text(index)
	
	return int(text)
