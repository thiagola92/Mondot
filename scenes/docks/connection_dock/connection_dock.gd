class_name ConnectionDock
extends MarginContainer


const DOCK_NAME: String = "Connections"

const Item: PackedScene = preload("./connection_item/connection_item.tscn")

@export var items_container: HFlowContainer


func _ready():
	connect_to_historic()
	load_items()


func connect_to_historic() -> void:
	Connections.connection_added.connect(add_item)
	Connections.connection_removed.connect(remove_item)


func add_item(connection_info: ConnectionInfo) -> void:
	var item: ConnectionItem = Item.instantiate()
	item.connection_info = connection_info
	items_container.add_child(item)


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


func _on_add_pressed() -> void:
	Connections.add_connection("localhost", PythonArgs.DEFAULT_URI)
