extends VBoxContainer


func _ready():
	pass


func _on_Run_pressed():
	var filepath = $Python.run($TextEditor.text)
	$ShellOutput.watch(filepath)


func _on_ShellOutput_next_page_requested():
	$Python.request_next_output()
