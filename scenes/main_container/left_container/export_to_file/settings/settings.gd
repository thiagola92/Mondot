extends HBoxContainer


func get_dir_path() -> String:
	return $DirectoryPath.text


func get_file_type() -> int:
	return $FileType.selected


func _on_SelectDir_pressed():
	$SelectDir/FileDialog.popup_centered()


func _on_FileDialog_dir_selected(dir):
	$DirectoryPath.text = dir
