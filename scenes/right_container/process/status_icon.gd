extends TextureRect

enum STATUS {
	UNKNOW,
	OK,
	WAITING,
	FAIL
}


func start_waiting():
	_change_status(STATUS.WAITING)


func _on_PythonWatcher_output(output, kwargs):
	var status = _get_output_status(output)
	
	_change_status(status)


func _get_output_status(output : String):
	var json = parse_json(output)
		
	if json == null:
		return STATUS.FAIL
	
	if json.get("error") == null:
		return STATUS.FAIL
	
	return STATUS.OK


func _change_status(status : int):
	match status:
		STATUS.UNKNOW:
			texture = null
		STATUS.OK:
			texture = load("res://images/icon_process_status_ok.svg")
		STATUS.WAITING:
			texture = load("res://scenes/right_container/process/waiting.tres")
		STATUS.FAIL:
			texture = load("res://images/icon_process_status_fail.svg")
	
