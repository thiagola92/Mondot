class_name SetupDock
extends MarginContainer


const DOCK_NAME: String = "Startup"

const SHELL_FILENAME: String = "shell"

const SHELL_FILEPATH: String = "user://shell"

const SHELL_URL: String = "https://github.com/thiagola92/MondotShell/releases/download/2.0.0/ubuntu.zip"

@export var progress_label: Label

@export var progress_bar: ProgressBar

@export var shell_downloader: HTTPRequest


func _ready() -> void:
	remove_python_files()
	download_shell_zip()


func remove_python_files() -> void:
	# Make sure that directory exists.
	if not DirAccess.dir_exists_absolute(PythonRunner.DIR_TMP):
		DirAccess.make_dir_absolute(PythonRunner.DIR_TMP)
	
	# Remove python files.
	for file in DirAccess.get_files_at(PythonRunner.DIR_TMP):
		DirAccess.remove_absolute("%s/%s" % [PythonRunner.DIR_TMP, file])
	
	progress_bar.value += 1


func download_shell_zip() -> void:
	if FileAccess.file_exists(PythonRunner.EXE_PATH):
		progress_bar.value += 1
		return
	
	shell_downloader.request(SHELL_URL)


func unzip_shell_zip() -> void:
	var zip = ZIPReader.new()
	var error = zip.open(shell_downloader.download_file)
	
	if error != OK:
		return
	
	var file = FileAccess.open(SHELL_FILEPATH, FileAccess.WRITE)
	
	file.store_buffer(zip.read_file(SHELL_FILENAME))
	zip.close()


func give_shell_exec_permission() -> void:
	var global_shell_path: String = ProjectSettings.globalize_path(SHELL_FILEPATH)
	var error = OS.execute("chmod", ["+x", global_shell_path])
	
	if error != OK:
		return


func remove_shell_zip() -> void:
	if FileAccess.file_exists(shell_downloader.download_file):
		DirAccess.remove_absolute(shell_downloader.download_file)


func _on_shell_downloader_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		return
	
	if response_code != HTTPClient.RESPONSE_OK:
		return
	
	unzip_shell_zip()
	give_shell_exec_permission()
	remove_shell_zip()
	
	progress_bar.value += 1


func _on_progress_bar_value_changed(value: float) -> void:
	if value >= progress_bar.max_value:
		queue_free()
