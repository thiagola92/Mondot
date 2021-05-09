extends HBoxContainer

var Shell = preload("res://scenes/right_container/shell/Shell.tscn")


func _ready():	
	$LeftContainer/Tree/Menu.connect(
		"open_shell_pressed", self,
		"_on_ConnectionMenu_open_shell_pressed"
	)


func _on_ConnectionMenu_open_shell_pressed():
	$RightContainer.add_tab("Shell", Shell.instance())
