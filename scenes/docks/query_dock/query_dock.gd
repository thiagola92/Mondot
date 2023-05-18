extends VSplitContainer


@onready var python_paginator: PythonPaginator = $PythonPaginator

@onready var query_code: TextEdit = $QueryContainer/QueryCode

@onready var result_json: TextEdit = $ResultContainer/ResultJson

@onready var result_menu: ResultMenu = $ResultContainer/ResultMenu


func _on_query_menu_play_pressed() -> void:
	var python_args = PythonArgs.new()
	python_paginator.run(query_code.text, python_args)


func _on_query_menu_stop_pressed() -> void:
	python_paginator.kill_current_execution()


func _on_python_paginator_page_changed(content: String, number: int) -> void:
	result_json.text = content
	result_menu.page = number
