extends Node


func go_to_next_occurrence(textedit : TextEdit, text : String) -> bool:
	var result = search_next_occurrence(textedit, text)
	
	if result.size() <= 0:
		return false
		
	select_word(
		textedit,
		result[TextEdit.SEARCH_RESULT_LINE],
		result[TextEdit.SEARCH_RESULT_COLUMN],
		len(text)
	)
	
	return true


func search_next_occurrence(textedit : TextEdit, text : String):
	if textedit.cursor_get_column() == get_column_count(textedit):
		go_to_next_line(textedit)
		go_to_first_column(textedit)
		
	return textedit.search(
		text,
		TextEdit.SEARCH_MATCH_CASE,
		textedit.cursor_get_line(),
		textedit.cursor_get_column() + 1
	)


func get_column_count(textedit : TextEdit):
	var line = textedit.cursor_get_line()
	
	return len(textedit.get_line(line))


func go_to_next_line(textedit : TextEdit):
	var line = textedit.cursor_get_line()
	
	if line == textedit.get_line_count():
		line = 0
	
	textedit.cursor_set_line(line + 1)


func go_to_first_column(textedit : TextEdit):
	textedit.cursor_set_column(0)


func select_word(textedit : TextEdit, line : int, column : int, length : int):
	textedit.cursor_set_line(line)
	textedit.cursor_set_column(column)
	textedit.select(line, column, line, column + length)


func go_to_previous_occurrence(textedit : TextEdit, text : String) -> bool:
	var result = search_previous_occurrence(textedit, text)
	
	if result.size() <= 0:
		return false
		
	select_word(
		textedit,
		result[TextEdit.SEARCH_RESULT_LINE],
		result[TextEdit.SEARCH_RESULT_COLUMN],
		len(text)
	)
	
	return true


func search_previous_occurrence(textedit : TextEdit, text : String):
	if textedit.cursor_get_column() == 0:
		go_to_previous_line(textedit)
		go_to_last_column(textedit)
	
	if textedit.cursor_get_line() == 0 and textedit.cursor_get_column() == 0:
		go_to_last_line(textedit)
		go_to_last_column(textedit)
	
	return textedit.search(
		text,
		TextEdit.SEARCH_BACKWARDS,
		textedit.cursor_get_line(),
		textedit.cursor_get_column() -1
	)


func go_to_previous_line(textedit : TextEdit):
	var line = textedit.cursor_get_line()
	
	if line == 0:
		line = textedit.get_line_count()
	
	textedit.cursor_set_line(line - 1)


func go_to_last_column(textedit : TextEdit):
	var column = get_column_count(textedit)
	
	textedit.cursor_set_column(column - 1)


func go_to_last_line(textedit : TextEdit):
	var line = textedit.get_line_count()
	
	textedit.cursor_set_line(line - 1)


func go_to_current_or_next_occurrence(textedit : TextEdit, text : String) -> bool:
	var result = search_current_or_next_occurrence(textedit, text)
	
	if result.size() <= 0:
		return false
		
	select_word(
		textedit,
		result[TextEdit.SEARCH_RESULT_LINE],
		result[TextEdit.SEARCH_RESULT_COLUMN],
		len(text)
	)
	
	return true


func search_current_or_next_occurrence(textedit : TextEdit, text : String):
	return textedit.search(
		text,
		TextEdit.SEARCH_MATCH_CASE,
		textedit.cursor_get_line(),
		textedit.cursor_get_column()
	)
	
