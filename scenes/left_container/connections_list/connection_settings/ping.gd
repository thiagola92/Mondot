extends HBoxContainer


func _ready():
	pass


func test_connection(connection : Dictionary):
	_stop_output_timer()
	_stop_test_connection()
	_start_test_connection(connection)
	_start_output_timer()


func _stop_output_timer():
	$OutputTimer.stop()


func _stop_test_connection():
	$Python.kill_current_execution()
	$Output.text = ""


func _start_test_connection(connection : Dictionary):
	var code = "self.db.command('ping')"
	var uri = URIParser.unparse(connection)
	var db = connection.get("db", "admin")
	
	$Python.run(code, uri, db)


func _start_output_timer():
	$OutputTimer.start()


func _on_Ping_hide():
	_stop_test_connection()
	_stop_output_timer()


func _on_OutputTimer_timeout():
	if $Python.output_exists():
		_stop_output_timer()
		_update_ping_output()
	else:
		_update_waiting_output()


func _update_ping_output():
	var parser_result = JSON.parse($Python.read_output())
	
	$Output.text = str(parser_result.result)


func _update_waiting_output():
	if len($Output.text) >= 3:
		$Output.text = ""
	$Output.text += "." 
