extends HBoxContainer


func _ready():
	pass


func test_connection(connection : Dictionary):
	var code = "self.db.command('ping')"
	var uri = $URIParser.unparse(connection)
	var db = connection.get("db", "admin")
	
	$PingOutput.text = ""
	$Python.run(code, uri, db)
	$OutputTimer.start()


func _on_OutputTimer_timeout():
	if $Python.output_exists():
		_update_ping_output()
	else:
		_update_waiting_output()


func _update_ping_output():
	$OutputTimer.stop()
	var parser_result = JSON.parse($Python.read_output())
	
	$PingOutput.text = str(parser_result.result)


func _update_waiting_output():
	if len($PingOutput.text) >= 3:
		$PingOutput.text = ""
	$PingOutput.text += "." 
