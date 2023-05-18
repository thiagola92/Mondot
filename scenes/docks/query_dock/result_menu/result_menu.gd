class_name ResultMenu
extends HFlowContainer


signal next_pressed

signal previous_pressed

@onready var loading: TextureRect = $Loading

@export var search_bar: SearchBar

@onready var page: int:
	set(p):
		_page.text = str(p)

@onready var _page: Label = $Page


func _ready():
	loading.hide()


func _on_next_pressed() -> void:
	next_pressed.emit()


func _on_previous_pressed() -> void:
	previous_pressed.emit()


func _on_search_toggled(button_pressed: bool) -> void:
	if search_bar and button_pressed:
		search_bar.show()
	elif search_bar and not button_pressed:
		search_bar.hide()
