extends VBoxContainer


var search_result : PoolIntArray = PoolIntArray([])
var search_current_line : int = 0
var search_current_column : int = 0


func _ready():
	pass


func set_readonly(readonly : bool = false):
	$TextEditor.readonly = readonly


func get_code() -> String:
	return $TextEditor.text


func clear_code():
	$TextEditor.text = ""


func update_code(text : String):
	$TextEditor.text = text


func open_search_menu():
	$SearchMenu.show()


func close_search_menu():
	$SearchMenu.hide()


func _on_Search_text_changed(new_text : String):
	_go_to_current_or_next_occurrence(new_text)


func _go_to_current_or_next_occurrence(new_text : String):
	TextEditKit.go_to_current_or_next_occurrence($TextEditor, new_text)


func _on_TextEditor_text_changed():
	if _is_search_open():
		_count_occurrences()


func _is_search_open():
	return $SearchMenu.visible


func _count_occurrences():
	pass


func _on_Previous_pressed():
	_go_to_previous_occurrence()


func _go_to_previous_occurrence():
	var text = $SearchMenu/Search.text
	TextEditKit.go_to_previous_occurrence($TextEditor, text)


func _on_Next_pressed():
	_go_to_next_occurrence()


func _go_to_next_occurrence():
	var text = $SearchMenu/Search.text
	TextEditKit.go_to_next_occurrence($TextEditor, text)
