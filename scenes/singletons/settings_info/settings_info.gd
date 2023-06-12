class_name SettingsInfo
extends Node


signal frequency_which_check_outputs_changed(seconds: float)

signal frequency_which_check_inputs_changed(seconds: float)

######### New docks will be affected

var page_size: int = 10

######### All docks will be affected

var frequency_which_check_outputs: float = 1.0:
	set(v):
		frequency_which_check_outputs = v
		frequency_which_check_outputs_changed.emit(v)

var frequency_which_check_inputs: float = 1.0:
	set(v):
		frequency_which_check_inputs = v
		frequency_which_check_inputs_changed.emit(v)

