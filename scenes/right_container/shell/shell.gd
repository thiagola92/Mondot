extends VBoxContainer

var filepath

func _ready():
	filepath = _create_code_file('')

func _create_code_file(content: String):
	var random_name = _generate_random_name()
	var filepath = "tmp/%s.js" % random_name
	var file = File.new()
	
	file.open(filepath, File.WRITE)
	file.store_string(content)
	file.close()
	
	return filepath


func _generate_random_name():
	var rng = RandomNumberGenerator.new()
	var random_array = PoolByteArray([])
	
	rng.randomize()
	
	for position in range(1, 9):
		random_array.append(rng.randi_range(97, 122))
	
	return random_array.get_string_from_ascii()


func _delete_code_file():
	var directory = Directory.new()
	var result_code = directory.remove(filepath)
	
	if result_code != OK:
		$Alert.message('Fail to remove file:\n%s' % filepath)


func _on_Run_pressed():
	var uri = 'mongodb://username:password@127.0.0.1:27017'
	
	var pid = OS.execute('bin/python', [filepath], false)

	print(pid)
	
	_delete_code_file()
