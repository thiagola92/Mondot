extends Control


var temporary_folder = "tmp/"


func _ready():
	_create_directory(temporary_folder)
	
	if not _is_directory_empty(temporary_folder):
		$Confirm.popup_centered()


func _create_directory(path : String):
	var directory = Directory.new()
	
	if directory.open(path) == OK:
		return
	
	directory.make_dir(path)


func _is_directory_empty(path : String) -> bool:
	var directory = Directory.new()
	
	directory.open(path)
	directory.list_dir_begin(true)
	
	if directory.get_next() == "":
		return true
	
	directory.list_dir_end()
	
	return false


func _on_Confirm_confirmed():
	_clean_directory(temporary_folder)


func _clean_directory(path : String):
	var directory = Directory.new()
	
	if directory.open(path) != OK:
		return
	
	directory.list_dir_begin(true)
	_delete_directory_files(directory)
	directory.list_dir_end()

func _delete_directory_files(directory : Directory):
	var absolute_path = directory.get_current_dir()
	var filename = directory.get_next()
	
	while filename:
		if directory.current_is_dir():
			_clean_directory("%s/%s" % [absolute_path, filename])
		directory.remove("%s/%s" % [absolute_path, filename])
			
		filename = directory.get_next()
			
	
