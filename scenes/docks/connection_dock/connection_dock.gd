class_name ConnectionDock
extends MarginContainer


const DOCK_NAME: String = "Connections"

const Item: PackedScene = preload("./connection_item/connection_item.tscn")

@export var scroll_container: ScrollContainer

@export var items_container: HFlowContainer


func _ready():
	listen_to_connections_changes()
	load_items()


func listen_to_connections_changes() -> void:
	Connections.connection_added.connect(add_item.bind(false))
	Connections.connection_removed.connect(remove_item)


func add_item(connection_info: ConnectionInfo, locked: bool = true) -> void:
	var item: ConnectionItem = Item.instantiate()
	item.connection_info = connection_info
	items_container.add_child(item)
	
	if not locked:
		item.press_unlock()


func remove_item(connection_info: ConnectionInfo) -> void:
	for item in items_container.get_children():
		if item is ConnectionItem:
			if item.connection_info == connection_info:
				items_container.remove_child(item)
				break


func clear_items():
	for child in items_container.get_children():
		child.queue_free()


func load_items() -> void:
	Connections.import()
	
	for c in Connections.connections:
		add_item(c)


func scroll_to_end() -> void:
	scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value


func _on_add_pressed() -> void:
	Connections.add_connection("localhost", PythonArgs.DEFAULT_URI)
	scroll_to_end()
