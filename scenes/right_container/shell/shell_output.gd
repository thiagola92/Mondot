extends VBoxContainer

var page_number = 0


func _ready():
	hide()


func clear():
	$Output.text = ""
	show()


func _on_PythonWatcher_output(output : String, _kwargs : Dictionary):
	var page_number = $PythonWatcher.page_number
	
	$Menu/PageNumber.text = str(page_number)
	$Output.text = MondotPython.pretty_output(output)


func _on_Next_pressed():
	$PythonWatcher.read_next_page()


func _on_Previous_pressed():
	$PythonWatcher.read_previous_page()
