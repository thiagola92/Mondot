class_name QueryIndexes
extends MarginContainer


@export var indexes_grid: GridContainer

@export var query_code: QueryCode


func _ready() -> void:
	clear_grid()


func clear_grid() -> void:
	for child in indexes_grid.get_children():
		indexes_grid.remove_child(child)
	
	for text in ["index", "connection", "database", "collection"]:
		var button = Button.new()
		button.text = text
		button.disabled = true
		indexes_grid.add_child(button)


func add_index_line(index: int, connection_path: ConnectionPath) -> void:
	var alias: String = connection_path.connection_info.connection_name
	var database: String = connection_path.database
	var collection: String = connection_path.collection
	
	var index_label = Label.new()
	var alias_button = Button.new()
	var database_button = Button.new()
	var collection_button = Button.new()
	
	index_label.text = str(index)
	alias_button.text = alias
	database_button.text = database
	collection_button.text = collection
	
	alias_button.pressed.connect(insert_text_on_caret.bind("self.clients[%s]" % index))
	database_button.pressed.connect(insert_text_on_caret.bind("self.dbs[%s]" % index))
	collection_button.pressed.connect(insert_text_on_caret.bind("self.cols[%s]" % index))
	
	connection_path.connection_info.connection_name_changed.connect(
		func(c: ConnectionInfo): alias_button.text = c.connection_name
	)
	
	indexes_grid.add_child(index_label)
	indexes_grid.add_child(alias_button)
	indexes_grid.add_child(database_button)
	indexes_grid.add_child(collection_button)


func add_indexes_lines(connections_paths: Array[ConnectionPath]) -> void:
	clear_grid()
	
	for index in connections_paths.size():
		add_index_line(index, connections_paths[index])


func insert_text_on_caret(text: String) -> void:
	query_code.insert_text_at_caret(text)
