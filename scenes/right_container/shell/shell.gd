extends VBoxContainer


func _ready():
	pass


func _on_Run_pressed():
	print("Running: ", $TextEditor.text)
