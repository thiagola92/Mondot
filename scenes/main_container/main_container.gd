extends HBoxContainer

var Shell = preload("res://scenes/main_container/right_container/shell/Shell.tscn")
var Process = preload("res://scenes/main_container/right_container/process/Process.tscn")


func _ready():
	pass


func _on_LeftContainer_shell_requested(uri : String, db : String, code : String):
	var shell = Shell.instance()
	
	shell.setup(uri, db, code)
	
	$RightContainer.add_tab("Shell", shell)


func _on_LeftContainer_process_requested(uri : String, db : String, code : String):
	var process = Process.instance()
	
	process.setup(uri, db, code)
	
	$RightContainer.add_tab("Process", process)
