extends VBoxContainer


var uri : String
var db : String


func _ready():
	pass


func setup(connection : Dictionary):
	uri = $URIParser.unparse(connection)
	db = connection.get("db", "admin")


func _on_Run_pressed():
	$ShellOutput/Python.run($TextEditor.text, uri, db)
	$ShellOutput.start()
