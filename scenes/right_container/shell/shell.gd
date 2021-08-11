extends VBoxContainer

var filepath = null
var pid = null


func _ready():
	pass


func _on_Run_pressed():
	# Remove old execution
	_delete_output_files()
	_delete_code_file()
	_kill_process()
	
	filepath = _create_code_file($TextEditor.text)
	pid = OS.execute('bin/python', ["bin/run.py", "--filepath", filepath], false)
	
	$ShellOutput.show_output(filepath)

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
	_delete_output_files()
	_delete_code_file()
	_kill_process()


func _delete_output_files():
	if filepath == null:
		return
	
	# Instead of searching every file that starts with the name XXXXXX
	# and remove XXXXXX_1, XXXXXX_2, XXXXXX_3, ...
	# I will just try to delete XXXXXX_1, XXXXXX_2, XXXXXX_3, ...
	# until it fail to delete any of them
	
	var counter = 1
	var directory = Directory.new()
	var result_code = directory.remove("%s_%s" % [filepath, counter])
	
	while result_code == OK:
		counter += 1
		result_code = directory.remove("%s_%s" % [filepath, counter])


func _delete_code_file():
	if filepath == null:
		return
	
	var directory = Directory.new()
	var result_code = directory.remove(filepath)
	
	if result_code != OK:
		return $Alert.message("Fail to remove file:\n%s" % filepath)


func _kill_process():
	if pid == null:
		return
	
	var result_code = OS.kill(pid)
	
	if result_code != OK:
		return $Alert.message("Fail to kill process %s (maybe is already dead?)" % pid)
