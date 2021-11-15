extends VBoxContainer


func _ready():
	hide()


func clear():
	$Output.text = ""
	show()


func _on_PythonWatcher_output(result : GenericResult, _kwargs : Dictionary):
	_update_page_number()
	_update_output(result)
	_hide_running_icon()


func _update_page_number():
	var current_page = $PythonWatcher/PythonPager.current_page
	$Menu/PageNumber.text = str(current_page)


func _update_output(result : GenericResult):
	$Output.text = MondotPython.pretty_result(result)


func _hide_running_icon():
	$Menu/Running.hide()


func _on_Next_pressed():
	$PythonWatcher.request_next_page()
	_show_running_icon()


func _show_running_icon():
	$Menu/Running.show()


func _on_Previous_pressed():
	$PythonWatcher.request_previous_page()
