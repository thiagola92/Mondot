extends HBoxContainer


func _ready():
	pass


func get_name() -> String:
	return $NameInput.text


func get_folder() -> String:
	return $FolderInput.selected
