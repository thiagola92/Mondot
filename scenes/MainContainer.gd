extends HBoxContainer

var Shell = preload("res://scenes/rightcontainer/shell/Shell.tscn")


func _ready():	
	$LeftContainer/ConnectionsTree/ConnectionMenu.connect(
		"open_shell_pressed", self,
		"_on_ConnectionMenu_open_shell_pressed"
	)


func _on_ConnectionMenu_open_shell_pressed():
	$RightContainer.add_tab("Shell", Shell.instance())
