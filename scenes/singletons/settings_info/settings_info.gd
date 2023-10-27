class_name SettingsInfo
extends Node


signal frequency_which_check_outputs_changed(seconds: float)

signal frequency_which_check_inputs_changed(seconds: float)

# Mondot

var theme: Theme:
	set(t):
		theme = t
		get_tree().root.theme = t

# Query dock

var page_size: int = 10

var frequency_which_check_outputs: float = 0.1:
	set(v):
		frequency_which_check_outputs = v
		frequency_which_check_outputs_changed.emit(v)

var frequency_which_check_inputs: float = 0.1:
	set(v):
		frequency_which_check_inputs = v
		frequency_which_check_inputs_changed.emit(v)


func _ready() -> void:
	get_tree().root.theme = theme
