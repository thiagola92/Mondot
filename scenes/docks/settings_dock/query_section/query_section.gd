class_name QuerySection
extends VBoxContainer


func _on_page_size_value_changed(value: float) -> void:
	Settings.page_size = int(value)


func _on_frequency_line_value_changed(value: float) -> void:
	Settings.frequency_which_check_results = value
