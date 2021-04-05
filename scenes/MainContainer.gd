extends HBoxContainer


func _ready():	
	$LeftPanel/ConnectionsTree/ConnectionMenu.connect(
		"open_shell_pressed", self,
		"_on_ConnectionMenu_open_shell_pressed"
	)


func _on_ConnectionMenu_open_shell_pressed():
	var l = Label.new()
	l.text = str($RightContainer/Tabs.get_tab_count())
	$RightContainer.add_tab("Shell" + l.text , l)
