extends VBoxContainer

var filepath = null
var pid = null


func _ready():
	pass


func _create_code_file(content: String) -> String:
	var random_name = _generate_random_name()
	var filepath = "tmp/%s.py" % random_name
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


func _on_Run_pressed():
	_delete_code_file()
	
	filepath = _create_code_file($TextEditor.text)
#	var pid = OS.execute('bin/python', [filepath], false)
#
#	print(pid)


func _on_Shell_tree_exiting():
	_delete_code_file()
	_kill_process()


func _delete_code_file():
	if filepath == null:
		return
	
	var directory = Directory.new()
	var result_code = directory.remove(filepath)
	
	if result_code != OK:
		$Alert.message("Fail to remove file:\n%s" % filepath)


func _kill_process():
	if pid == null:
		return
	
	var result_code = OS.kill(pid)
	
	if result_code != OK:
		$Alert.message("Fail to kill the process. It could be already dead.")
