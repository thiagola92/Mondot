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

@export var connection_button: ConnectionButton

@export var page_size_spin: SpinBox

@export var search_bar: SearchBar

@export var query_indexes: QueryIndexes

var uris: Array[String] = []

var databases: Array[String] = []

var collections: Array[String] = []

var connections_paths: Array[ConnectionPath]:
	get:
		return connection_button.connections_paths

var page_size: int = 10

@onready var search_button: Button = $Search


func _ready() -> void:
	page_size_spin.value = Settings.page_size


func update_database_fields() -> void:
	uris.clear()
	databases.clear()
	collections.clear()
	
	for connection_path in connections_paths:
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


func _on_search_toggled(toggled_on: bool) -> void:
	if toggled_on:
		search_bar.show()
	else:
		search_bar.hide()


func _on_indexes_toggled(toggled_on: bool) -> void:
	if toggled_on:
		query_indexes.show()
	else:
		query_indexes.hide()


func _on_connection_button_changed() -> void:
	update_database_fields()
	connection_changed.emit()
