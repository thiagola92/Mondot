## Responsible to give MondotShell a python code to run.
## Only this class should interact with files from shell and the shell process.
class_name PythonRunner
extends Node

## Reference: [url]https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html[/url][br]
const DIR_TMP: String = "user://tmp"

## Reference: [url]https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html[/url][br]
const EXE_PATH: String = "res://shell"

const INPUT_SUFFIX: String = "in"

const OUTPUT_SUFFIX: String = "out"

## Filename is made of random characters that change every execution.
var filename: String

## Process identifier responsible for running current shell.
var pid: int

## Path to file containing the code to be processed.
var code_path: String:
	get:
		return "%s/%s" % [DIR_TMP, filename]

## Path to file where shell expect inputs.
var input_path: String:
	get:
		return "%s_%s" % [code_path, INPUT_SUFFIX]

## Path to file containing the result from shell.
var output_path: String:
	get:
		return "%s_%s" % [code_path, OUTPUT_SUFFIX]


func _ready() -> void:
	DirAccess.make_dir_absolute(DIR_TMP)


## [b]Note[/b]: Can be reused to run others codes,
## in this case it will kill previous execution before starting a new one.
func run(code: String, args: PythonArgs) -> void:
	kill_current_execution()
	start_new_execution(code, args)


## Terminate current shell process and delete it files.
## [br]
## [br][b]Note[/b]: It's very important that the signal [signal Node.tree_exiting] call this method,
## otherwise the user could end with many processes in the background and files from queries.
func kill_current_execution() -> void:
	kill_process()
	delete_files()
	
	filename = ""
	pid = 0


## Kill the current shell process exeucting the code.
func kill_process() -> void:
	if pid > 0:
		OS.kill(pid)


## Delete all files related to the current shell execution.
func delete_files() -> void:
	if filename.is_empty():
		return
	
	var dir: DirAccess = DirAccess.open(DIR_TMP)
	
	dir.remove(code_path)
	dir.remove(input_path)
	
	# Doesn't try to know how many output files exist.
	# It will try to delete output_1, output_2, output_3, ...
	# and keep going until it fail to delete one.
	var counter = 1
	var result_code = dir.remove("%s_%s" % [output_path, counter])
	
	while result_code == Error.OK:
		counter += 1
		result_code = dir.remove("%s_%s" % [output_path, counter])


## Start a shell process for a specific code.
## [br]It will keep trying generate a random [member filename] that doesn't exist.
## [br]
## [br][b]Note[/b]: It could lock you in loop forever if you have more than
## 3.814697266×10¹² docks 💩.
func start_new_execution(code: String, args: PythonArgs) -> void:
	filename = RandomUtility.rands_ascii(9, 97, 122)
	
	# Keep trying to find a filename that is not in use.
	while FileAccess.file_exists(code_path):
		filename = RandomUtility.rands_ascii(9, 97, 122)
	
	var file: FileAccess = FileAccess.open(code_path, FileAccess.WRITE)
	var arguments: Array[String] = args.to_array(code_path)
	
	file.store_string(code)
	
	var global_exe_path = ProjectSettings.globalize_path(EXE_PATH)
	
	pid = OS.create_process(global_exe_path, arguments)


## Read the output [code]number[/code]. In case it doesn't exists, returns an empty [String].
## It's recommended to check if the output exists with [method output_exists].
## [br]
## [br][b]Note[/b]:
func read_output(number: int) -> String:
	if not output_exists(number):
		return ""
	
	var path = "%s_%s" % [output_path, str(number)]
	var file = FileAccess.open(path, FileAccess.READ)
	
	if file != null:
		return file.get_as_text()
	return ""


## Returns if the output [code]number[/code] already exists or not.
## Even if the file exists, this doesn't mean that MondotShell finished writing the output.
func output_exists(number: int) -> bool:
	if filename.is_empty():
		return false
	
	var path = "%s_%s" % [output_path, str(number)]
	
	if not FileAccess.file_exists(path):
		return false
		
	var file = FileAccess.open(path, FileAccess.READ)
	
	return file.get_length() > 0


## Request the next output from MondotShell.
func request_next_output() -> void:
	# Right now MondotShell do not care about the input it receive.
	# It's only important that is not an empty string.
	FileAccess.open(input_path, FileAccess.WRITE).store_string("next")
