class_name SettingsInfo
extends Node


const SETTINGS_FILE = "user://settings.json"

signal frequency_which_check_outputs_changed(seconds: float)

signal frequency_which_check_inputs_changed(seconds: float)

# Mondot

var theme: String = "main":
	set(t):
		theme = t
		get_tree().root.theme = load("res://themes/%s.tres" % t)

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
	var file = FileAccess.open(SETTINGS_FILE, FileAccess.READ)
	
	if file == null:
		return print_debug("No settings file found.")
	
	var json = JSON.parse_string(file.get_as_text())
	
	if json == null:
		return print_debug("Fail to load settings file.")
	
	theme = json.get("theme", theme)
	page_size = json.get("page_size", page_size)
	frequency_which_check_outputs = json.get("frequency_which_check_outputs", frequency_which_check_outputs)
	frequency_which_check_inputs = json.get("frequency_which_check_inputs", frequency_which_check_inputs)


func _on_tree_exiting() -> void:
	var file = FileAccess.open(SETTINGS_FILE, FileAccess.WRITE)
	
	if file == null:
		return print_debug("Fail to create the settings file.")
	
	var json = JSON.stringify({
		"theme": theme,
		"page_size": page_size,
		"frequency_which_check_outputs": frequency_which_check_outputs,
		"frequency_which_check_inputs": frequency_which_check_inputs,
	}, "  ")
	
	file.store_string(json)
