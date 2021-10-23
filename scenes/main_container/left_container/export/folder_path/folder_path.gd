extends HBoxContainer


signal dir_selected(dir)


var extension = ".csv"


func _on_Select_pressed():
	$Select/FolderSelect.popup_centered()


func _on_FolderSelect_dir_selected(dir):
	$Path.text = dir
	
	emit_signal("dir_selected", dir)


func _on_ConnectionPath_draw():
	hide()


func _on_FileType_item_selected(index):
	match index:
		0:
			extension = ".csv"
		1:
			extension = ".json"
	
