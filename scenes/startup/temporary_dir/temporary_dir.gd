extends ConfirmationDialog


var tmp_dir = "tmp/"


func _ready():
	DirectoryKit.create_directory(tmp_dir)
	
	if not DirectoryKit.is_directory_empty(tmp_dir):
		call_deferred("popup_centered")


func _on_TemporaryDir_confirmed():
	DirectoryKit.clean_directory(tmp_dir)
