extends VBoxContainer


var filepath = null
var pid = null


func _ready():
	pass


func _on_Run_pressed():
	_kill_current_execution() # Remove old execution
	
	filepath = _create_code_file($TextEditor.text)
	pid = OS.execute('bin/python', ["bin/run.py", "--filepath", filepath], false)
	
	$ShellOutput.watch(filepath)


func _kill_current_execution():
	_kill_process()
	_delete_code_file()
	_delete_input_file()
	_delete_output_files()


func _kill_process():
	if pid != null:
		OS.kill(pid)


func _delete_code_file():
	if filepath == null:
		return
	
	Directory.new().remove(filepath)


func _delete_input_file():
	if filepath == null:
		return
	
	Directory.new().remove("%s_i" % filepath)


func _delete_output_files():
	if filepath == null:
		return
	
	# Doesn't try to know how many output files exist
	# It will try to delete the next file if in the previous succeed
	
	var counter = 1
	var directory = Directory.new()
	var result_code = directory.remove("%s_%s" % [filepath, counter])
	
	while result_code == OK:
		counter += 1
		result_code = directory.remove("%s_%s" % [filepath, counter])


func _create_code_file(content: String) -> String:
	var random_name = _generate_random_name()
	var filepath = "tmp/%s" % random_name
	var file = File.new()
	
	file.open(filepath, File.WRITE)
	file.store_string(content)
	file.close()
	
	return filepath


func _generate_random_name() -> String:
	var rng = RandomNumberGenerator.new()
	var random_array = PoolByteArray([])
	
	rng.randomize()
	
	for position in range(1, 9):
		random_array.append(rng.randi_range(97, 122))
	
	return random_array.get_string_from_ascii()


func _on_Shell_tree_exiting():
	_kill_current_execution()


func _on_ShellOutput_next_page_requested():
	_write_input_file("next")


func _write_input_file(content : String):
	var file = File.new()
	
	file.open("%s_i" % filepath, File.WRITE)
	file.store_string(content)
	file.close()
