extends VBoxContainer


const HistoryItem = preload("res://scenes/docks/history_dock/history_item/history_item.tscn")


func _ready() -> void:
	add_item("asdf", PythonArgs.new())
	add_item("123", PythonArgs.new())
	add_item("xcv", PythonArgs.new())
	add_item("5", PythonArgs.new())


func add_item(code: String, args: PythonArgs) -> void:
	var history_item = HistoryItem.instantiate()
	add_child(history_item)
	history_item.init(code, args)
