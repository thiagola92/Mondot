extends HBoxContainer

var Shell = preload("res://scenes/main_container/right_container/shell/Shell.tscn")


func _ready():
	pass


func _on_LeftContainer_shell_requested(uri : String, db : String, code : String, readonly : bool, hidden : bool):
	var shell = Shell.instance()
	
	shell.setup(uri, db, code, readonly, hidden)
	
	$RightContainer.add_tab("Shell", shell)
