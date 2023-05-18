## Responsible to give MondotShell a python code to run.
## Only this class should interact with files from shell and the shell process.
class_name PythonRunner
extends Node


const DIR_TMP: String = "res://tmp"

const EXE_PATH: String = "res://bin/run"

const INPUT_SUFFIX: String = "in"

const OUTPUT_SUFFIX: String = "out"

var filename: String

var pid: int

## Path to file containing the code processed by MondotShell.
var code_path: String:
	get:
		return "%s/%s" % [DIR_TMP, filename]

## Path to file where MondotShell expect inputs.
var input_path: String:
	get:
		return "%s_%s" % [code_path, INPUT_SUFFIX]

## Path to file containing the result of MondotShell.
var output_path: String:
	get:
		return "%s_%s" % [code_path, OUTPUT_SUFFIX]


## [b]Note[/b]: A PythonRunner can be reused to run others codes,
## in this case it will kill previous execution before starting a new one.
func run(code: String, args: PythonArgs) -> void:
	kill_current_execution()
	_start_new_execution(code, args)


## Terminate MondotShell process and delete it files.
## [br][b]Note[/b]: It's very important that the signal [signal Node.tree_exiting] call this method,
## otherwise the user could end with many processes in the background and files from queries.
func kill_current_execution() -> void:
	_kill_process()
	_delete_files()
	
	filename = ""
	pid = 0


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


## Read the output [code]number[/code]. In case it doesn't exists, returns an empty [String].
## It's recommended to check if the output exists with [method output_exists].
func read_output(number: int) -> String:
	if not output_exists(number):
		return ""
	
	var path = "%s_%s" % [output_path, str(number)]
	var file = FileAccess.open(path, FileAccess.READ)
	
	if file != null:
		return file.get_as_text()
	return ""


## Request the next output from MondotShell.
func request_next_output() -> void:
	# Right now MondotShell do not care about the input it receive.
	# It's only important that is not an empty string.
	FileAccess.open(input_path, FileAccess.WRITE).store_string("next")


func _delete_files() -> void:
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


func _kill_process() -> void:
	if pid > 0:
		OS.kill(pid)


func _start_new_execution(code: String, args: PythonArgs) -> void:
	filename = RandomUtility.rands_ascii(9, 97, 122)
	
	# Keep trying to find a filename that is not in use.
	while FileAccess.file_exists(code_path):
		filename = RandomUtility.rands_ascii(9, 97, 122)
	
	var file: FileAccess = FileAccess.open(code_path, FileAccess.WRITE)
	var arguments: Array[String] = args.to_array(code_path)
	
	file.store_string(code)
	
	var global_exe_path = ProjectSettings.globalize_path(EXE_PATH)
	
	pid = OS.create_process(global_exe_path, arguments)
