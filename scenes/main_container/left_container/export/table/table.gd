extends GridContainer


const headers = [
	"Database",
	"Collection",
	"target",
	"",
]


func _ready():
	clear()


func clear():
	_clean_grid()
	_add_headers()
	add_line("yes", "no", "maybe")


func add_line(db : String, collection : String, target : String):
	var columns = [
		_create_source_line_edit(db),
		_create_source_line_edit(collection),
		_create_target_line_edit(target)
	]
	
	for column in columns:
		add_child(column)
		
	_add_remove_button(columns)


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
	
	return line_edit


func _create_target_line_edit(text : String):
	var line_edit = LineEdit.new()
	line_edit.text = text
	line_edit.editable = true
	
	return line_edit


func _add_remove_button(columns : Array):
	var remove_button = Button.new()
	remove_button.icon = load(MondotIcon.REMOVE)
	
	columns.append(remove_button)
	remove_button.connect("pressed", self, "_on_RemoveButton_pressed", [columns])
	
	add_child(remove_button)


func _on_RemoveButton_pressed(columns):
	for column in columns:
		column.queue_free()
