class_name StartupTask
extends Node


signal completed(message: String, steps: int)

signal progressed(message: String, step: bool)

signal failed

var last_message: String = ""

@export var steps: int = 0


func start() -> void:
	pass


## Notify that the task has completed.
func complete() -> void:
	completed.emit(last_message + "✔️", steps)


## Notify that the task has progressed.
func progress(message: String) -> void:
	# Conclude previous message.
	if not last_message.is_empty():
		progressed.emit(last_message + "✔️", true)
		steps -= 1
	
	progressed.emit(message, false)
	last_message = message


## Notify that the task has failied.
func fail() -> void:
	failed.emit(last_message + "❌")
