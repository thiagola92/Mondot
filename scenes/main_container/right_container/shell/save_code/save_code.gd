extends FileDialog


var code : String = ""


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()
	
	set_filters(PoolStringArray(["*.py ; Python File"]))
	
	# This is a fix
	# When you select any filter option, it will write on LineEdit that filter option
	_get_option_button().connect("item_selected", self, "_on_OptionButton_item_selected")


func save(_code : String):
	self.code = _code
	
	popup_centered()


func _get_option_button():
	return _get_last_hbox().get_child(2)


func _get_last_hbox():
	return get_vbox().get_child(3)


func _on_OptionButton_item_selected(_index):
	get_line_edit().text = ""


func _on_SaveCode_file_selected(path):
	var file = File.new()
	
	file.open(path, File.WRITE)
	file.store_string(self.code)
	file.close()
