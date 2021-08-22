extends Node

signal timeout(kwargs)
signal output(output, kwargs)


var timeout : float
var kwargs : Dictionary


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
	
	self.timeout = timeout
	self.kwargs = kwargs
	
	_start_timers()
	
	return $Python.run(code, uri, db, page_size)


func _start_timers():
	# Never kill if there is no timeout
	if self.timeout > 0:
		$KillTimer.start(timeout)
	
	$OutputTimer.start()


func _on_KillTimer_timeout():
	$OutputTimer.stop()
	$Python.kill_current_execution()
	
	emit_signal("timeout", kwargs)


func _on_OutputTimer_timeout():
	if $Python.output_exists():
		_stop_timers()
		
		emit_signal("output", $Python.read_output(), kwargs)


func _stop_timers():
	$KillTimer.stop()
	$OutputTimer.stop()
