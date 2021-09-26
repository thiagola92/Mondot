extends VBoxContainer


func _ready():
	hide()


func clear():
	$Output.text = ""
	show()


func _on_PythonWatcher_output(output : String, _kwargs : Dictionary):
	var current_page = $PythonWatcher.current_page
	
	$Menu/PageNumber.text = str(current_page)
	$Output.text = MondotPython.pretty_output(output)


func _on_Next_pressed():
	$PythonWatcher.read_next_page()


func _on_Previous_pressed():
	$PythonWatcher.read_previous_page()
