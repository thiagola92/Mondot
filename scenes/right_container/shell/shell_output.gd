extends VBoxContainer

signal next_page_requested

var filepath = null
var page_number = 1


func _ready():
	hide()


func watch(filepath : String):
	self.filepath = filepath
	_read_output()
	show()


func _read_output():
	var output_path = "%s_%s" % [filepath, page_number]
	
	$Menu/PageNumber.text = str(page_number)
	$Output.text = _read_file(output_path)
	

func _read_file(filepath : String):
	var file = File.new()
	
	file.open(filepath, File.READ)
	var content = file.get_as_text()
	file.close()
	
	return content


func _on_Refresh_pressed():
	_read_output()


func _on_Previous_pressed():
	if page_number > 1:
		page_number -= 1
		_read_output()


func _on_Next_pressed():
	_go_to_next_output()


func _go_to_next_output():
	if _next_output_exists():
		page_number += 1
		_read_output()
	else:
		emit_signal("next_page_requested")
		$Timer.start()


func _next_output_exists():
	var output_path = "%s_%s" % [filepath, page_number + 1]
	var file = File.new()
	
	return file.file_exists(output_path)


func _on_Timer_timeout():
	_go_to_next_output()
