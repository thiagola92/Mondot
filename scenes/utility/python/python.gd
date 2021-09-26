extends Node


var filepath = null
var pid = null


func _ready():
	pass


func run(code : String, uri : String, db : String, page_size : int = 20) -> String:
	kill_current_execution() # Remove old execution
	
	filepath = _create_code_file(code)
	
	var args = [
		"--input", filepath,
		"--uri", uri,
		"--database", db,
		"--page_size", page_size
	]
	
	print("bin/run %s %s %s %s %s %s %s %s" % args)
	pid = OS.execute('bin/run', args, false)
	
	return filepath


func kill_current_execution():
	_kill_process()
	_delete_code_file()
	_delete_input_file()
	_delete_output_files()


func read_output(output : int = 1) -> String:
	return _read_output_file("%s_%s" % [filepath, output])


func output_exists(output : int = 1) -> bool:
	var file_exist = File.new().file_exists("%s_%s" % [filepath, output])
	
	if not file_exist:
		return false
	
	var output_length = _get_output_length("%s_%s" % [filepath, output])
	
	return output_length > 0


func request_next_output():
	_write_input_file("next")


func _kill_process():
	if pid != null:
		var _error = OS.kill(pid)


func _delete_code_file():
	if filepath == null:
		return
	
	var _error = Directory.new().remove(filepath)


func _delete_input_file():
	if filepath == null:
		return
	
	var _error = Directory.new().remove("%s_i" % filepath)


func _delete_output_files():
	if filepath == null:
		return
	
	# Doesn't try to know how many output files exist.
	# It will try to delete output_1, output_2, output_3, ...
	# and keep going until it fail to delete one.
	
	var counter = 1
	var directory = Directory.new()
	var result_code = directory.remove("%s_%s" % [filepath, counter])
	
	while result_code == OK:
		counter += 1
		result_code = directory.remove("%s_%s" % [filepath, counter])


func _create_code_file(content: String) -> String:
	var random_name = _generate_random_name()
	var temporary_file = "tmp/%s" % random_name
	var file = File.new()
	
	file.open(temporary_file, File.WRITE)
	file.store_string(content)
	file.close()
	
	return temporary_file


func _generate_random_name() -> String:
	var rng = RandomNumberGenerator.new()
	var random_array = PoolByteArray([])
	
	rng.randomize()
	
	for _position in range(1, 9):
		random_array.append(rng.randi_range(97, 122))
	
	return random_array.get_string_from_ascii()
	

func _read_output_file(output_path : String) -> String:
	var file = File.new()
	
	file.open(output_path, File.READ)
	var content = file.get_as_text()
	file.close()
	
	return content
	

func _get_output_length(output_path : String) -> int:
	var file = File.new()
	
	file.open(output_path, File.READ)
	var length = file.get_len()
	file.close()
	
	return length


func _write_input_file(content : String):
	var file = File.new()
	
	file.open("%s_i" % filepath, File.WRITE)
	file.store_string(content)
	file.close()


func _on_Python_tree_exiting():
	kill_current_execution()
