extends HBoxContainer

var Shell = preload("res://scenes/main_container/right_container/shell/Shell.tscn")


func _ready():
	pass


func _on_LeftContainer_shell_requested(uri : String, db : String, code : String, readonly : bool):
	var shell = Shell.instance()
	
	shell.setup(uri, db, code, readonly)
	
	$RightContainer.add_tab("Shell", shell)
