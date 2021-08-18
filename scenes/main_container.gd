extends HBoxContainer

var Shell = preload("res://scenes/right_container/shell/Shell.tscn")


func _ready():
	pass


func _on_LeftContainer_shell_requested(connection):
	var shell = Shell.instance()
	
	shell.setup(connection)
	
	$RightContainer.add_tab("Shell", shell)
