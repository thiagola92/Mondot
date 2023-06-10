class_name QueryMenu
extends HFlowContainer


## Emitted when user press the play button.
signal play_pressed

## Emitted when user press the stop button.
signal stop_pressed

## Emitted when user save the current query code.
signal save_pressed

@export var search_bar: SearchBar

@export var connection_menu: ConnectionMenu

@export var database_menu: DatabaseMenu

@export var page_size_spin: SpinBox

var uris: Array[String] = []

var databases: Array[String] = []

var page_size: int = 10


func _ready() -> void:
	page_size_spin.value = Settings.page_size


func _on_play_pressed() -> void:
	play_pressed.emit()


func _on_stop_pressed() -> void:
	stop_pressed.emit()


func _on_save_pressed() -> void:
	save_pressed.emit()


func _on_connection_menu_connection_checked(connection_info: ConnectionInfo) -> void:
	database_menu.add_connection(connection_info)


func _on_connection_menu_connection_unchecked(connection_info: ConnectionInfo) -> void:
	database_menu.remove_connection(connection_info)


func _on_database_menu_connection_added(uris_dbs: Array[Array]) -> void:
	uris = uris_dbs[0]
	databases = uris_dbs[1]


func _on_database_menu_connection_removed(uris_dbs: Array[Array]) -> void:
	uris = uris_dbs[0]
	databases = uris_dbs[1]


func _on_database_menu_database_checked(uris_dbs: Array[Array]) -> void:
	uris = uris_dbs[0]
	databases = uris_dbs[1]


func _on_page_size_spin_value_changed(value: float) -> void:
	page_size = int(value)


func _on_search_toggled(button_pressed: bool) -> void:
	if button_pressed:
		search_bar.show()
	else:
		search_bar.hide()
