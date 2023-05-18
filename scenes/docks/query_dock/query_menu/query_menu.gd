extends HFlowContainer


signal play_pressed

signal save_pressed

signal stop_pressed

@export var search_bar: SearchBar

@onready var page_size: int = 10:
	get:
		if _page_size:
			return _page_size.get_selected_id()
		return page_size

@onready var _page_size: OptionButton = $PageSize


func _on_play_pressed() -> void:
	play_pressed.emit()


func _on_save_pressed() -> void:
	save_pressed.emit()


func _on_stop_pressed() -> void:
	stop_pressed.emit()


func _on_search_toggled(button_pressed: bool) -> void:
	if search_bar and button_pressed:
		search_bar.show()
	elif search_bar and not button_pressed:
		search_bar.hide()
