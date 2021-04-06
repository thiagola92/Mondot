extends HBoxContainer


func _ready():	
	$LeftPanel/ConnectionsTree/ConnectionMenu.connect(
		"open_shell_pressed", self,
		"_on_ConnectionMenu_open_shell_pressed"
	)


func _on_ConnectionMenu_open_shell_pressed():
	var shell = preload("res://scenes/rightcontainer/shell/Shell.tscn")
	$RightContainer.add_tab("Shell", shell.instance())
