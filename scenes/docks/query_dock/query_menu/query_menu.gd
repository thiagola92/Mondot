class_name QueryMenu
extends HFlowContainer


## Emitted when user press the play button.
signal play_pressed

## Emitted when user press the stop button.
signal stop_pressed

## Emitted when user save the current query code.
signal save_pressed

@export var search_bar: SearchBar

@export var connection_option: OptionButton

@export var database_option: OptionButton

@export var page_size_option: OptionButton

var connection: String = "mongodb://127.0.0.1:27017"

var database: String = "admin"

var page_size: int = 10


func _on_play_pressed() -> void:
	play_pressed.emit()


func _on_stop_pressed() -> void:
	stop_pressed.emit()


func _on_save_pressed() -> void:
	save_pressed.emit()


func _on_search_toggled(button_pressed: bool) -> void:
	if search_bar and button_pressed:
		search_bar.show()
	elif search_bar and not button_pressed:
		search_bar.hide()


func _on_connection_item_selected(index):
	connection = connection_option.get_item_text(index)


func _on_database_item_selected(index):
	database = database_option.get_item_text(index)


func _on_page_size_item_selected(index):
	page_size = int(page_size_option.get_item_text(index))
