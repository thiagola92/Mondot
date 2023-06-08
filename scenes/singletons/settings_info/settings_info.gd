class_name SettingsInfo
extends Node


signal frequency_which_check_results_changed(seconds: float)

# New docks will be affected

var page_size: int = 10

# All docks will be affected

var frequency_which_check_results: float = 1.0:
	set(v):
		frequency_which_check_results = v
		frequency_which_check_results_changed.emit(v)

