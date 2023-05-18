class_name PythonPaginator
extends Node


signal page_changed(content: String, number: int)

var page_count: int = 0

var current_page: int = 0

@onready var python_runner: PythonRunner = $PythonRunner

@onready var timer: Timer = $Timer


## [b]Note[/b]: A PythonPaginator can be reused to run others codes,
## in this case it will kill previous execution before starting a new one.
func run(code: String, args: PythonArgs) -> void:
	kill_current_execution()
	_start_new_execution(code, args)


## Terminate [PythonRunner] execution and reset pagination.
func kill_current_execution() -> void:
	timer.stop()
	python_runner.kill_current_execution()
	
	page_count = 0
	current_page = 0


## [b]Note[/b]: Requesting next page more than once have no effect. Until the
## current request finish, others requests are ignored.
func request_next_page() -> void:
	if not timer.is_stopped():
		return
	
	if current_page == page_count:
		python_runner.request_next_output()
		timer.start()
	elif current_page < page_count:
		_check_next_page()


func request_previous_page() -> void:
	if current_page > 1:
		current_page -= 1
		
		var content: String = python_runner.read_output(current_page)
		
		page_changed.emit(content, current_page)


func _check_next_page() -> void:
	if python_runner.output_exists(current_page + 1):
		timer.stop()
		
		current_page += 1
		
		if current_page > page_count:
			page_count = current_page
		
		var content: String = python_runner.read_output(current_page)
		
		page_changed.emit(content, current_page)


func _start_new_execution(code: String, args: PythonArgs) -> void:
	python_runner.run(code, args)
	timer.start()


func _on_timer_timeout() -> void:
	_check_next_page()
