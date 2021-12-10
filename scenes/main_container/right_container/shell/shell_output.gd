extends VBoxContainer


func _ready():
	$Output.set_readonly(true)
	
	hide()


func clear():
	$Output.clear_code()
	
	show()


func _on_PythonWatcher_output(result : GenericResult, _kwargs : Dictionary):
	_hide_running_icon()
	_update_page_number()
	_update_output(result)


func _update_page_number():
	var current_page = $PythonWatcher.get_current_page()
	$Menu/PageNumber.text = str(current_page)


func _update_output(result : GenericResult):
	$Output.update_code(MondotBeautifier.beautify_result(result))


func _hide_running_icon():
	$Menu/Running.hide()


func _on_Next_pressed():
	$PythonWatcher.request_next_page()
	_show_running_icon()


func _show_running_icon():
	$Menu/Running.show()


func _on_Previous_pressed():
	$PythonWatcher.request_previous_page()


func _on_Search_toggled(button_pressed):
	if button_pressed:
		$Output.open_search_menu()
	else:
		$Output.close_search_menu()
