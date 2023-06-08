class_name ResultMenu
extends HFlowContainer


signal next_pressed

signal previous_pressed

@export var search_bar: SearchBar

@export var loading: TextureRect

@export var eof: Button

@export var page_label: Label

var page: int:
	set(p):
		page = p
		page_label.text = str(p)


func _ready():
	loading.hide()
	eof.hide()


func _on_next_pressed() -> void:
	next_pressed.emit()


func _on_previous_pressed() -> void:
	previous_pressed.emit()


func _on_search_toggled(button_pressed: bool) -> void:
	if search_bar and button_pressed:
		search_bar.show()
	elif search_bar and not button_pressed:
		search_bar.hide()
