extends HBoxContainer


func _ready():
	pass


func test_connection(connection : Dictionary):
	var code = "self.db.command('ping')"
	
	$PythonWatcher.run(code, connection["uri"], "admin")


func _on_Ping_hide():
	$PythonWatcher.kill_current_execution()


func _on_PythonWatcher_output(output, kwargs):
	var parse_result = MondotPython.parse_output(output)
	
	if parse_result.error != OK:
		return $Alert.message(parse_result.error_string)
	
	$Output.text = str(parse_result.result)
	$PythonWatcher.kill_current_execution()
