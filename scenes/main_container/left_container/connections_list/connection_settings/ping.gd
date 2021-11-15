extends HBoxContainer


func _ready():
	pass


func test_connection(connection : Dictionary):
	var code = "self.db.command('ping')"
	
	$PythonWatcher.run(code, connection["uri"], "admin")


func _on_Ping_hide():
	$PythonWatcher.kill_current_execution()


func _on_PythonWatcher_output(result : GenericResult, _kwargs : Dictionary):
	if result.error != OK:
		return Alert.message(result.error_string)
	
	$Output.text = str(result.result)
	$PythonWatcher.kill_current_execution()
