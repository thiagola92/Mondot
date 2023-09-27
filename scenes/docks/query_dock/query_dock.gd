class_name QueryDock
extends MarginContainer


const DOCK_NAME: String = "Query"

@export var query_menu: QueryMenu

@export var query_code: TextEdit

@export var result_menu: ResultMenu

@export var result_warning: WarningBar

@export var result_json: JSONEdit

@export var python_paginator: PythonPaginator

@export var python_parser: PythonParser

@export var save_window: FileDialog


func clear_result():
	result_json.text = ""
	result_menu.eof.hide()
	result_warning.hide_message()


func set_code(code: String) -> void:
	query_code.text = code.lstrip(" \n").replace("	", "    ")


func _on_query_menu_play_pressed() -> void:
	var python_args = PythonArgs.new()
	python_args.uris = query_menu.uris
	python_args.dbs = query_menu.databases
	python_args.cols = query_menu.collections
	python_args.page_size = query_menu.page_size
	python_args.timer = Settings.frequency_which_check_inputs
	
	Historic.add_query(query_code.text, python_args)
	python_paginator.run(query_code.text, python_args)


func _on_query_menu_stop_pressed() -> void:
	python_paginator.kill_current_execution()


func _on_query_menu_save_pressed() -> void:
	save_window.show()


func _on_save_window_file_selected(path: String) -> void:
	FileAccess.open(path, FileAccess.WRITE).store_string(query_code.text)


func _on_result_menu_previous_pressed() -> void:
	python_paginator.request_previous_page()


func _on_result_menu_next_pressed() -> void:
	if python_parser.error_code == OK:
		python_paginator.request_next_page()


func _on_python_paginator_page_changed(content: String, number: int) -> void:
	python_parser.parse(content)
	result_menu.page = number


func _on_python_parser_parsing_finished(content: Variant) -> void:
	clear_result()
	result_json.text = str(content)


func _on_python_parser_python_code_ended() -> void:
	result_menu.eof.show()


func _on_python_parser_parsing_json_failed(line: int, message: String) -> void:
	clear_result()
	result_warning.show_message("Failed to parse shell output to JSON.")
	printt(line, message) # TODO: Log instead of printing


func _on_python_parser_parsing_structure_failed(type) -> void:
	clear_result()
	result_warning.show_message("Failed because JSON root was not an Object (Dictionary).")
	printt(type) # TODO: Log instead of printing


func _on_python_parser_python_code_failed(code, message) -> void:
	clear_result()
	
	if code == ERR_PARSE_ERROR:
		result_warning.show_message("Failed to create a JSON from result.")
	
	result_json.text = message
	printt(code, message) # TODO: Log instead of printing
