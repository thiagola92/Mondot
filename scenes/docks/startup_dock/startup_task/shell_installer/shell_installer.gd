extends StartupTask


const SHELL_FILENAME: String = "shell"

const SHELL_FILEPATH: String = "user://shell"

const SHELL_LINUX_URL: String = "https://github.com/thiagola92/MondotShell/releases/download/2.1.0/ubuntu.zip"

const SHELL_MACOS_URL: String = ""

const SHELL_WINDOWS_URL: String = ""

@export var shell_downloader: HTTPRequest


func start() -> void:
	download_shell_zip()


func download_shell_zip() -> void:
	progress("Downloading shell zip...")
	
	if FileAccess.file_exists(PythonRunner.EXE_PATH):
		complete()
		return
		
	match OS.get_name():
		"Linux":
			shell_downloader.request(SHELL_LINUX_URL)
		"macOS":
			shell_downloader.request(SHELL_MACOS_URL)
		"Windows":
			shell_downloader.request(SHELL_WINDOWS_URL)


func unzip_shell_zip() -> void:
	progress("Unzipping shell zip...")
	
	var zip = ZIPReader.new()
	var error = zip.open(shell_downloader.download_file)
	
	if error != OK:
		return
	
	var file = FileAccess.open(SHELL_FILEPATH, FileAccess.WRITE)
	
	file.store_buffer(zip.read_file(SHELL_FILENAME))
	zip.close()


func allow_shell_execution() -> void:
	progress("Allowing shell execution...")
	
	var global_shell_path: String = ProjectSettings.globalize_path(SHELL_FILEPATH)
	var error = OS.execute("chmod", ["+x", global_shell_path])
	
	if error != OK:
		return


func remove_shell_zip() -> void:
	progress("Removing shell zip...")
	
	if FileAccess.file_exists(shell_downloader.download_file):
		DirAccess.remove_absolute(shell_downloader.download_file)


func _on_shell_downloader_request_completed(result: int, response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		return
	
	if response_code != HTTPClient.RESPONSE_OK:
		return
	
	unzip_shell_zip()
	allow_shell_execution()
	remove_shell_zip()
	complete()
