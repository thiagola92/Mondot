extends VBoxContainer


var uri : String
var db : String


func _ready():
	pass


func setup(connection : Dictionary, code : String):
	uri = URIParser.unparse(connection)
	db = connection.get("db", "admin")
	
	$TextEditor.text = code


func _on_Run_pressed():
	_execute_python_code()


func _execute_python_code():
	var code = $TextEditor.text
	$ShellOutput/Python.run(code, uri, db)
	$ShellOutput.start()
