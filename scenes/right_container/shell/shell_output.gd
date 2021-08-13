extends VBoxContainer

signal next_page_requested

var filepath = null
var page_number = 0


func _ready():
	hide()


func watch(filepath : String):
	self.filepath = filepath
	self.page_number = 0
	
	$NextPage.start()
	show()


func _on_NextPage_timeout():
	_refresh_next_page()


func _refresh_next_page():
	if _next_page_exists():
		$NextPage.stop()
		_go_to_next_page()


func _next_page_exists():
	var output_path = "%s_%s" % [filepath, page_number + 1]
	var file = File.new()
	
	return file.file_exists(output_path)


func _go_to_next_page():
	page_number += 1
	_read_current_page()


func _read_current_page():
	var output_path = "%s_%s" % [filepath, page_number]
	
	$Menu/PageNumber.text = str(page_number)
	$Output.text = _read_file(output_path)
	

func _read_file(filepath : String) -> String:
	var file = File.new()
	
	file.open(filepath, File.READ)
	var content = file.get_as_text()
	file.close()
	
	return content


func _on_Refresh_pressed():
	_read_current_page()


func _on_Next_pressed():
	_request_next_page()


func _request_next_page():
	emit_signal("next_page_requested")
	$NextPage.start()


func _on_Previous_pressed():
	_go_to_previous_page()


func _go_to_previous_page():
	$NextPage.stop()
	
	if page_number > 1:
		page_number -= 1
		_read_current_page()
