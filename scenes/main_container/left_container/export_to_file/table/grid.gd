extends GridContainer


func clean():
	for child in get_children():
		remove_child(child)


func add_headers(headers : Array):
	for header in headers:
		_add_header(header)


func add_line_edit(text : String, editable : bool):
	var line_edit = LineEdit.new()
	
	line_edit.text = text
	line_edit.editable = editable
	line_edit.size_flags_horizontal = SIZE_EXPAND_FILL
	
	add_child(line_edit)
	
	return line_edit


func add_remove_button(columns : Array):
	var remove_button = Button.new()
	columns.append(remove_button)
	
	remove_button.icon = load(MondotIcon.REMOVE)
	remove_button.connect("pressed", self, "_on_RemoveButton_pressed", [columns])
	
	add_child(remove_button)


func _add_header(text : String):
	var label = Label.new()
	label.text = text
	add_child(label)


func _on_RemoveButton_pressed(columns):
	for column in columns:
		remove_child(column)
