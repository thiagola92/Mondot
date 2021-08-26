extends VBoxContainer

var page_number = 0


func _ready():
	hide()


func start():
	page_number = 0
	
	$Output.text = ""
	$NextPageTimer.start()
	show()


func _on_NextPageTimer_timeout():
	if _next_page_exists():
		_stop_next_page_timer()
		_read_next_page()


func _next_page_exists() -> bool:
	return $Python.output_exists(page_number + 1)


func _stop_next_page_timer():
	$NextPageTimer.stop()


func _read_next_page():
	page_number += 1
	_read_current_page()


func _read_current_page():
	$Menu/PageNumber.text = str(page_number)
	
#	var output = $Python.read_output(page_number)
#	$Output.text =  MondotPython.pretty_output(output)
	
	$Output.text =  $Python.read_output(page_number)


func _on_Next_pressed():
	if _next_page_exists():
		_read_next_page()
	else:
		_request_next_page()


func _request_next_page():
	$Python.request_next_output()
	_start_next_page_timer()


func _start_next_page_timer():
	$NextPageTimer.start()


func _on_Previous_pressed():
	_read_previous_page()


func _read_previous_page():
	_stop_next_page_timer()
	
	if page_number > 1:
		page_number -= 1
		_read_current_page()
