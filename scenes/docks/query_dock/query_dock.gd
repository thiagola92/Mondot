class_name QueryDock
extends MarginContainer

const DOCK_NAME: String = "Query"

@export var python_paginator: PythonPaginator

@export var query_code: TextEdit

@export var result_json: TextEdit

@export var result_menu: ResultMenu


func _on_query_menu_play_pressed() -> void:
	var python_args = PythonArgs.new()
	Historic.add_query(query_code.text, python_args)
	python_paginator.run(query_code.text, python_args)


func _on_query_menu_stop_pressed() -> void:
	python_paginator.kill_current_execution()


func _on_python_paginator_page_changed(content: String, number: int) -> void:
	result_json.text = content
	result_menu.page = number
