extends Node

signal timeout(kwargs)
signal output(output, kwargs)


var _timeout
var _kwargs
var current_page
var desired_page


func _ready():
	pass


func run(
		code : String,
		uri : String,
		db : String,
		page_size : int = 20,
		timeout : float = 0,
		kwargs : Dictionary = {}
	) -> String:
	
	_timeout = timeout
	_kwargs = kwargs
	current_page = 1
	desired_page = 1
	
	_start_timers()
	
	return $Python.run(code, uri, db, page_size)


func read_next_page():
	# Don't go to next page if didn't get the desired page yet
	if desired_page != current_page:
		return
		
	desired_page = current_page + 1
	
	if not $Python.output_exists(desired_page):
		$Python.request_next_output()
	
	_start_timers()


func read_previous_page():
	if current_page > 1:
		desired_page = current_page - 1
		_start_timers()


func kill_current_execution():
	_stop_timers()
	
	$Python.kill_current_execution()

func _start_timers():
	# Never kill if there is no timeout
	if _timeout > 0:
		$KillTimer.start(_timeout)
	
	$OutputTimer.start()


func _stop_timers():
	$KillTimer.stop()
	$OutputTimer.stop()


func _on_KillTimer_timeout():
	kill_current_execution()
	
	emit_signal("timeout", _kwargs)


func _on_OutputTimer_timeout():
	if $Python.output_exists(desired_page):
		_stop_timers()
		
		current_page = desired_page
		var output = $Python.read_output(current_page)
		
		emit_signal("output", output, _kwargs)
