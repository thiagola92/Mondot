extends VBoxContainer


func _ready():
	pass


func _on_Run_pressed():
	$ShellOutput/Python.run($TextEditor.text)
	$ShellOutput.start()
