class_name QuerySection
extends VBoxContainer


const SUCCESS: Texture = preload("res://icons/check_mark_green.svg")

const ERROR: Texture = preload("res://icons/cross_mark_red.svg")

@export var frequency_status: TextureRect


func _on_frequency_line_text_changed(new_text: String):
	if new_text.is_valid_float():
		frequency_status.texture = SUCCESS
		Settings.frequency_which_check_results = float(new_text)
	else:
		frequency_status.texture = ERROR
