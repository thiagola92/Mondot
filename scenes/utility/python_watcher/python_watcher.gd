extends Node

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
	) -> String:
	
	_timeout = timeout
	_kwargs = kwargs
	
	_start_timers()
	
	return $Python.run(code, uri, db, page_size)


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
	if $Python.output_exists():
		_stop_timers()
		
		emit_signal("output", $Python.read_output(), _kwargs)
