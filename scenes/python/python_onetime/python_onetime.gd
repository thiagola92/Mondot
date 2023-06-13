## Execute code through [PythonRunner] but will kill execution after first response. 
class_name PythonOnetime
extends Node


signal execution_finished(content: String)

@export var python_runner: PythonRunner

@export var timer: Timer


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


func check_page() -> void:
	if python_runner.output_exists(0):
		timer.stop()
		execution_finished.emit(python_runner.read_output(0))
		kill_current_execution()


func start_new_execution(code: String, args: PythonArgs) -> void:
	python_runner.run(code, args)
	timer.start()


func _on_timer_timeout() -> void:
	check_page()
