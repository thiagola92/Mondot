## Control the pagination over the [PythonRunner] result.
## [br]
## [br]It will increase as more pages are requested and help you navigating through existing pages.
class_name PythonPaginator
extends Node


signal page_changed(content: String, number: int)

## A value that indicates that no page have being processed.
## [br]Both [member last_page] and [member current_page] will have this value
## at the start of a new execution.
const NO_PAGE = -1

@export var python_runner: PythonRunner

@export var timer: Timer

## Last page know until now, this increase with each new page received from [PythonRunner].
## [br]
## [br][b]Note[/b]: It's [url="https://en.wikipedia.org/wiki/Zero-based_numbering"]zero-based numerbing[/url].
## [br][b]Note[/b]: The value of [constant NO_PAGE] indicates that no page exists.
var last_page: int = NO_PAGE

## The current page, it's alway less or equal to [member last_page].
## [br]
## [br][b]Note[/b]: It's [url="https://en.wikipedia.org/wiki/Zero-based_numbering"]zero-based numerbing[/url].
## [br][b]Note[/b]: The value of [constant NO_PAGE] indicates that no page exists.
var current_page: int = NO_PAGE


func _ready():
	Settings.frequency_which_check_outputs_changed.connect(
		func(s: float): timer.wait_time = s
	)


## [b]Note[/b]: Can be reused to run others codes,
## in this case it will kill previous execution before starting a new one.
func run(code: String, args: PythonArgs) -> void:
	kill_current_execution()
	start_new_execution(code, args)


## Terminate [PythonRunner] execution and reset pagination.
func kill_current_execution() -> void:
	timer.stop()
	python_runner.kill_current_execution()
	
	last_page = NO_PAGE
	current_page = NO_PAGE


## [b]Note[/b]: Requesting next page more than once have no effect. Until the
## current request finish, others requests are ignored.
func request_next_page() -> void:
	if not timer.is_stopped():
		return
	
	if current_page == last_page:
		python_runner.request_next_output()
		timer.start()
	elif current_page < last_page:
		check_next_page()


func request_previous_page() -> void:
	if current_page > 0:
		current_page -= 1
		
		var content: String = python_runner.read_output(current_page)
		
		page_changed.emit(content, current_page)


func check_next_page() -> void:
	if python_runner.output_exists(current_page + 1):
		timer.stop()
		
		current_page += 1
		
		if current_page > last_page:
			last_page = current_page
		
		var content: String = python_runner.read_output(current_page)
		
		page_changed.emit(content, current_page)


func start_new_execution(code: String, args: PythonArgs) -> void:
	python_runner.run(code, args)
	timer.start()


func _on_timer_timeout() -> void:
	check_next_page()
