extends VBoxContainer


var uri : String
var db : String


func _ready():
	pass


func setup(_uri : String, _db : String, code : String):
	self.uri = _uri
	self.db = _db
	
	$CodeEditor.text = code


func _on_Run_pressed():
	_execute_python_code()


func _execute_python_code():
	var code = $CodeEditor.text
	$PythonWatcher.run(code, uri, db)
	$Menu/StatusIcon.start_waiting()
