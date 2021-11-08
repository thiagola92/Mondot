extends HBoxContainer


var extension = ".csv"


func get_dir_path() -> String:
	return $Path.text


func _on_Select_pressed():
	$Select/DirSelect.popup_centered()


func _on_DirSelect_dir_selected(dir):
	$Path.text = dir


func _on_FileType_item_selected(index):
	match index:
		0:
			extension = ".csv"
		1:
			extension = ".json"
	
