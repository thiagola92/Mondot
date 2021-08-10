extends VBoxContainer

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()


func _create_temporary_file(content: String):
	var random_name = _generate_random_name()
	var filepath = "tmp/%s.js" % random_name
	var file = File.new()
	
	file.open(filepath, File.WRITE)
	file.store_string(content)
	file.close()
	
	return filepath


func _generate_random_name():
	var random_array = PoolByteArray([])
	
	for position in range(1, 9):
		random_array.append(rng.randi_range(97, 122))
	
	return random_array.get_string_from_ascii()


func _delete_temporary_file(path: String):
	var directory = Directory.new()
	var result_code = directory.remove(path)
	
	if result_code != OK:
		printt('fail to remove', result_code)


func _on_Run_pressed():
	var uri = 'mongodb://username:password@127.0.0.1:27017'
	var filepath = _create_temporary_file($TextEditor.text)
	
	var pid = OS.execute('bin/python', [filepath], false)

	print(pid)
	
	_delete_temporary_file(filepath)
