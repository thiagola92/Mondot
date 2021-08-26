extends HBoxContainer

var Shell = preload("res://scenes/right_container/shell/Shell.tscn")


func _ready():
	pass


func _on_LeftContainer_shell_requested(uri : String, code : String, db : String):
	var shell = Shell.instance()
	
	shell.setup(uri, code, db)
	
	$RightContainer.add_tab("Shell", shell)
