extends HBoxContainer


func _ready():
	pass


func _on_Select_pressed():
	$Select/FolderSelect.popup_centered()


func _on_FolderSelect_dir_selected(dir):
	$Path.text = dir
