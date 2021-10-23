extends VBoxContainer


func _ready():
	pass


func _on_ConnectionPath_draw():
	$FolderPath.hide()


func _on_FolderPath_draw():
	$ConnectionPath.hide()
