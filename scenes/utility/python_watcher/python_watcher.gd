extends Node

# PythonWatcher is responsible to watch for pages changes whenever requested.
# And it use signal to notify the content of the current page.


signal timeout(kwargs)
signal output(output, kwargs)


var _timeout
var _kwargs


func _ready():
	pass


func run(
		code : String,
		uri : String,
		db : String,
		page_size : int = 20,
		timeout : float = 0,
		kwargs : Dictionary = {}
	):
	
	_timeout = timeout
	_kwargs = kwargs
	
	kill_current_execution()
	
	$PythonPager.run(code, uri, db, page_size)
	
	_start_timers()


func request_next_page():
	if $PythonPager.request_next_page():
		_start_timers()


func request_previous_page():
	if $PythonPager.request_previous_page():
		_start_timers()


func kill_current_execution():
	_stop_timers()
	
	$PythonPager.kill_current_execution()


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
	if $PythonPager.gone_to_desired_page():
		_stop_timers()
		
		var output = $PythonPager.read_current_page()
		
		emit_signal("output", output, _kwargs)
