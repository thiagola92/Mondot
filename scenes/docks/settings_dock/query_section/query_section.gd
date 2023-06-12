class_name QuerySection
extends VBoxContainer


@export var page_size: SpinBox

@export var frequency_output: SpinBox

@export var frequency_input: SpinBox


func _ready() -> void:
	page_size.value = Settings.page_size
	frequency_output.value = Settings.frequency_which_check_outputs
	frequency_input.value = Settings.frequency_which_check_inputs


func _on_page_size_value_changed(value: float) -> void:
	Settings.page_size = int(value)


func _on_frequency_output_value_changed(value: float) -> void:
	Settings.frequency_which_check_outputs = value


func _on_frequency_input_value_changed(value: float) -> void:
	Settings.frequency_which_check_inputs = value
