extends StartupTask


const SHELL_FILENAME: String = "shell"

const SHELL_FILEPATH: String = "user://shell"

const SHELL_LINUX_URL: String = "https://github.com/thiagola92/MondotShell/releases/download/2.1.0/shell-linux.zip"

const SHELL_MACOS_URL: String = "https://github.com/thiagola92/MondotShell/releases/download/2.1.0/shell-macos.zip"

const SHELL_WINDOWS_URL: String = "https://github.com/thiagola92/MondotShell/releases/download/2.1.0/shell-windows.zip"

@export var shell_downloader: HTTPRequest


func start() -> void:
	download_shell_zip()


func download_shell_zip() -> void:
	progress("Downloading shell zip...")
	
	if FileAccess.file_exists(PythonRunner.EXE_PATH):
		return complete()
		
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
		return fail()
	
	var file = FileAccess.open(SHELL_FILEPATH, FileAccess.WRITE)
	var filename = SHELL_FILENAME
	
	if OS.get_name() == "Windows":
		filename += ".exe"

	var file_content = zip.read_file(filename)
	
	if not file_content:
		return fail()
	
	file.store_buffer(file_content)
	zip.close()


func allow_shell_execution() -> void:
	progress("Allowing shell execution...")
	
	if OS.get_name() == "Windows":
		return
	
	var global_shell_path: String = ProjectSettings.globalize_path(SHELL_FILEPATH)
	var error = OS.execute("chmod", ["+x", global_shell_path])
	
	if error != OK:
		return fail()


func remove_shell_zip() -> void:
	progress("Removing shell zip...")
	
	if FileAccess.file_exists(shell_downloader.download_file):
		DirAccess.remove_absolute(shell_downloader.download_file)


func _on_shell_downloader_request_completed(result: int, response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		return fail()
	
	if response_code != HTTPClient.RESPONSE_OK:
		return fail()
	
	unzip_shell_zip()
	allow_shell_execution()
	remove_shell_zip()
	complete()
