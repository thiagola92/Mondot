## UI to display and interacts with the [QueryHistory].
class_name HistoryDock
extends MarginContainer


const DOCK_NAME: String = "Historic"

const Item: PackedScene = preload("./history_item/history_item.tscn")

@export var items_container: VBoxContainer


func _ready() -> void:
	connect_to_historic()
	load_items()


func connect_to_historic() -> void:
	Historic.query_added.connect(add_item)
	Historic.query_removed.connect(remove_item)
	Historic.queries_cleared.connect(clear_items)


func add_item(query_info: QueryInfo) -> void:
	var item: HistoryItem = Item.instantiate()
	item.query_info = query_info
	items_container.add_child(item)
	items_container.move_child(item, 0)


func remove_item(query_info: QueryInfo) -> void:
	for item in items_container.get_children():
		if item is HistoryItem:
			if item.query_info == query_info:
				items_container.remove_child(item)
				break


func clear_items():
	for child in items_container.get_children():
		child.queue_free()


func load_items() -> void:
	Historic.import()
	ArrayUtility.process_reversed(Historic.queries, add_item)


func _on_clear_all_pressed() -> void:
	Historic.clear_queries()
