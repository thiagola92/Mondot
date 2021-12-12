extends Node


func go_to_next_occurrence(textedit : TextEdit, text : String) -> bool:
	_go_to_next_character(textedit)
	
	var result = _search_forward_occurrence(textedit, text)
	
	return _select_result(textedit, result, text)


func go_to_previous_occurrence(textedit : TextEdit, text : String) -> bool:
	_go_to_previous_character(textedit)
	
	var result = _search_backward_occurrence(textedit, text)
	
	return _select_result(textedit, result, text)


func go_to_current_or_next_occurrence(textedit : TextEdit, text : String) -> bool:
	var result = _search_forward_occurrence(textedit, text)
	
	return _select_result(textedit, result, text)


### GO TO X CHARACTER ###


func _go_to_next_character(textedit : TextEdit):
	if _is_on_last_column(textedit):
		_go_to_next_line(textedit)
		_go_to_first_column(textedit)
	else:
		_move_cursor_column(textedit, 1)


func _go_to_previous_character(textedit : TextEdit):
	if _is_on_first_column(textedit):
		_go_to_previous_line(textedit)
		_go_to_last_column(textedit)
	else:
		_move_cursor_column(textedit, -1)


### GO TO X LINE ###


func _go_to_next_line(textedit : TextEdit):
	if _is_on_last_line(textedit):
		_go_to_first_line(textedit)
	else:
		_move_cursor_line(textedit, 1)


func _go_to_first_line(textedit : TextEdit):
	textedit.cursor_set_line(0)


func _go_to_previous_line(textedit : TextEdit):
	if _is_on_first_line(textedit):
		_go_to_last_line(textedit)
	else:
		_move_cursor_line(textedit, -1)


func _go_to_last_line(textedit : TextEdit):
	var line = textedit.get_line_count()
	
	textedit.cursor_set_line(line - 1)


### GO TO X COLUMN ###


func _go_to_first_column(textedit : TextEdit):
	textedit.cursor_set_column(0)


func _go_to_last_column(textedit : TextEdit):
	var column = _get_column_count(textedit)
	
	textedit.cursor_set_column(column - 1)


### IS ON X LINE ###


func _is_on_first_line(textedit : TextEdit):
	return textedit.cursor_get_line() == 0


func _is_on_last_line(textedit : TextEdit):
	return textedit.cursor_get_line() == textedit.get_line_count()


### IS ON X COLUMN ###


func _is_on_first_column(textedit : TextEdit):
	return textedit.cursor_get_column() == 0


func _is_on_last_column(textedit : TextEdit):
	return textedit.cursor_get_column() == _get_column_count(textedit)


### COLUMN COUNT ###


func _get_column_count(textedit : TextEdit):
	var line = textedit.cursor_get_line()
	
	return len(textedit.get_line(line))


### MOVE CURSOR X ###


func _move_cursor_line(textedit : TextEdit, lines : int):
	var line = textedit.cursor_get_line()
	textedit.cursor_set_line(line + lines)


func _move_cursor_column(textedit : TextEdit, columns : int):
	var column = textedit.cursor_get_column()
	textedit.cursor_set_column(column + columns)


### SEARCH X OCCURRENCE ###


func _search_forward_occurrence(textedit : TextEdit, text : String):
	return textedit.search(
		text,
		TextEdit.SEARCH_MATCH_CASE,
		textedit.cursor_get_line(),
		textedit.cursor_get_column()
	)


func _search_backward_occurrence(textedit : TextEdit, text : String):
	return textedit.search(
		text,
		TextEdit.SEARCH_BACKWARDS,
		textedit.cursor_get_line(),
		textedit.cursor_get_column()
	)


### SELECT ###


func _select_result(textedit : TextEdit, result : PoolIntArray, text):
	if result.size() <= 0:
		return false
		
	_select_word(
		textedit,
		result[TextEdit.SEARCH_RESULT_LINE],
		result[TextEdit.SEARCH_RESULT_COLUMN],
		len(text)
	)
	
	return true


func _select_word(textedit : TextEdit, line : int, column : int, length : int):
	textedit.cursor_set_line(line)
	textedit.cursor_set_column(column)
	textedit.select(line, column, line, column + length)
	
