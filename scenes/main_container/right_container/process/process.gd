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


func _on_View_toggled(button_pressed):
	if button_pressed:
		return _show_uri()
	return _hide_uri()


func _show_uri():
	$CodeEditor.show()
	$Menu/View.icon = load(MondotIcon.VISIBILITY_VISIBLE)


func _hide_uri():
	$CodeEditor.hide()
	$Menu/View.icon = load(MondotIcon.VISIBILITY_HIDDEN)
