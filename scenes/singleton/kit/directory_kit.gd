extends Node


func create_directory(path : String):
	var directory = Directory.new()
	
	if directory.dir_exists(path):
		return
	
	directory.open("")
	directory.make_dir(path)


func is_directory_empty(path : String) -> bool:
	var directory = Directory.new()
	
	directory.open(path)
	directory.list_dir_begin(true)
	
	if directory.get_next() == "":
		return true
	
	directory.list_dir_end()
	
	return false


func clean_directory(path : String):
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
			clean_directory("%s/%s" % [absolute_path, filename])
			
		var _error = directory.remove("%s/%s" % [absolute_path, filename])
		
		filename = directory.get_next()
