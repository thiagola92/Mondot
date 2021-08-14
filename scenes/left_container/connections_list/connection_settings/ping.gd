extends HBoxContainer


func _ready():
	pass


func _on_TestConnection_pressed():
	# Python code here
	$Python.run("import time; time.sleep(3); 10")
	$OutputTimer.start()


func _on_OutputTimer_timeout():
	if $Python.output_exists(1):
		_update_ping_output()
	else:
		_update_waiting_output()


func _update_ping_output():
	$OutputTimer.stop()
	$PingOutput.text = $Python.read_output(1)


func _update_waiting_output():
	if len($PingOutput.text) >= 3:
		$PingOutput.text = ""
	$PingOutput.text += "." 
