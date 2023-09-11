extends StartupTask


func start() -> void:
	remove_python_files()


func remove_python_files() -> void:
	progress("Removing python files...")
	
	# Make sure that directory exists.
	if not DirAccess.dir_exists_absolute(PythonRunner.DIR_TMP):
		DirAccess.make_dir_absolute(PythonRunner.DIR_TMP)
	
	# Remove python files.
	for file in DirAccess.get_files_at(PythonRunner.DIR_TMP):
		DirAccess.remove_absolute("%s/%s" % [PythonRunner.DIR_TMP, file])
		
	complete()
