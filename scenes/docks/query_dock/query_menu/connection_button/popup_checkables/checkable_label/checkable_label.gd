class_name CheckableLabel
extends HBoxContainer


## Emitted when the checkbox is checked.
signal checked

## Emitted when the checkbox is unchecked.
signal unchecked

@export var checkbox: CheckBox

@export var label: Label

## If [code]true[/code], checkbox is checked.
var is_checked: bool:
	get:
		return checkbox.button_pressed

## Label text.
var text: String:
	set(t):
		label.text = t
	get:
		return label.text


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		checked.emit()
	else:
		unchecked.emit()
