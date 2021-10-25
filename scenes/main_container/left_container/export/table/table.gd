extends GridContainer


const headers = [
	"Source database",
	"Source collection",
	"Target collection",
	"",
]


func _ready():
	clear()
	
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		add_line("source_database0", "source_collection0", "target_collection0")
		add_line("source_database1", "source_collection1", "target_collection1")
		add_line("source_database2", "source_collection2", "target_collection2")


func clear():
	_clean_grid()
	_add_headers()


func add_line(db : String, collection : String, target : String):
	var columns = [
		_create_source_line_edit(db),
		_create_source_line_edit(collection),
		_create_target_line_edit(target)
	]
	
	for column in columns:
		add_child(column)
		
	_add_remove_button(columns)


func get_lines():
	var lines = []
	
	for index in range(columns, get_child_count(), columns):
		lines.append({
			"db_source": get_child(index).text,
			"col_source": get_child(index + 1).text,
			"col_target": get_child(index + 2).text
		})
	
	return lines


func _clean_grid():
	for child in get_children():
		remove_child(child)


func _add_headers():
	for header in headers:
		_add_header(header)


func _add_header(text : String):
	var label = Label.new()
	label.text = text
	add_child(label)


func _create_source_line_edit(text : String):
	var line_edit = LineEdit.new()
	
	line_edit.text = text
	line_edit.editable = false
	line_edit.size_flags_horizontal = SIZE_EXPAND_FILL
	
	return line_edit


func _create_target_line_edit(text : String):
	var line_edit = LineEdit.new()
	
	line_edit.text = text
	line_edit.editable = true
	line_edit.size_flags_horizontal = SIZE_EXPAND_FILL
	
	return line_edit


func _add_remove_button(columns : Array):
	var remove_button = Button.new()
	columns.append(remove_button)
	
	remove_button.icon = load(MondotIcon.REMOVE)
	remove_button.connect("pressed", self, "_on_RemoveButton_pressed", [columns])
	
	add_child(remove_button)


func _on_RemoveButton_pressed(columns):
	for column in columns:
		column.queue_free()
