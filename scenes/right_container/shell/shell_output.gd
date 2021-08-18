extends VBoxContainer

var page_number = 0


func _ready():
	hide()


func start():
	page_number = 0
	
	$Output.text = ""
	$NextPage.start()
	show()


func _on_NextPage_timeout():
	_refresh_next_page()


func _refresh_next_page():
	if _next_page_exists():
		$NextPage.stop()
		_go_to_next_page()


func _next_page_exists():
	return $Python.output_exists(page_number + 1)


func _go_to_next_page():
	page_number += 1
	_read_current_page()


func _read_current_page():
	$Menu/PageNumber.text = str(page_number)
	$Output.text = $Python.read_output(page_number)


func _on_Next_pressed():
	if _next_page_exists():
		_go_to_next_page()
	else:
		_request_next_page()


func _request_next_page():
	$Python.request_next_output()
	$NextPage.start()


func _on_Previous_pressed():
	_go_to_previous_page()


func _go_to_previous_page():
	$NextPage.stop()
	
	if page_number > 1:
		page_number -= 1
		_read_current_page()
