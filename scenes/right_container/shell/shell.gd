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
	$ShellOutput/Python.run(code, uri, db)
	$ShellOutput.start()
