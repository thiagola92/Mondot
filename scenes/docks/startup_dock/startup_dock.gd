class_name SetupDock
extends MarginContainer


const DOCK_NAME: String = "Startup"


@export var progress_messages: TextEdit

@export var progress_bar: ProgressBar

@export var startup_tasks: Node


func _ready() -> void:
	calculate_progress_bar_max_value()
	connect_tasks_signals()
	start_tasks.call_deferred()


func calculate_progress_bar_max_value() -> void:
	progress_bar.max_value = 0
	
	for child in startup_tasks.get_children():
		if child is StartupTask:
			progress_bar.max_value += child.steps


func connect_tasks_signals() -> void:
	for child in startup_tasks.get_children():
		if child is StartupTask:
			child.completed.connect(_on_task_completed)
			child.progressed.connect(_on_task_progressed)
			child.failed.connect(_on_task_failed)


func start_tasks() -> void:
	for child in startup_tasks.get_children():
		if child is StartupTask:
			child.start()


func _on_task_completed(message: String, steps: int) -> void:
	progress_messages.text += message + "\n"
	progress_bar.value += steps


func _on_task_progressed(message: String, step: bool) -> void:
	progress_messages.text += message + "\n"
	progress_bar.value += (1 if step else 0)


func _on_task_failed(message: String) -> void:
	progress_messages.text += message + "\n"
	# TODO: Decide what to do on errors


func _on_progress_bar_value_changed(value: float) -> void:
	if value >= progress_bar.max_value:
		queue_free()
