class_name QueryMenu
extends HFlowContainer


## Emitted when user press the play button.
signal play_pressed

## Emitted when user press the stop button.
signal stop_pressed

## Emitted when user save the current query code.
signal save_pressed

## Emitted when user change connections.
signal connection_changed

@export var search_bar: SearchBar

@export var connection_button: ConnectionButton

@export var page_size_spin: SpinBox

var uris: Array[String] = []

var databases: Array[String] = []

var collections: Array[String] = []

var page_size: int = 10


func _ready() -> void:
	page_size_spin.value = Settings.page_size


func update_database_fields() -> void:
	uris.clear()
	databases.clear()
	collections.clear()
	
	for connection_path in connection_button.connections_paths:
		uris.append(connection_path.connection_info.connection_uri)
		databases.append(connection_path.database)
		collections.append(connection_path.collection)


func _on_play_pressed() -> void:
	play_pressed.emit()


func _on_stop_pressed() -> void:
	stop_pressed.emit()


func _on_save_pressed() -> void:
	save_pressed.emit()


func _on_page_size_spin_value_changed(value: float) -> void:
	page_size = int(value)


func _on_search_toggled(button_pressed: bool) -> void:
	if button_pressed:
		search_bar.show()
	else:
		search_bar.hide()


func _on_connection_button_changed() -> void:
	update_database_fields()
	connection_changed.emit()
