class_name Menu
extends VBoxContainer


@export var docks: Docks


func _on_query_pressed() -> void:
	docks.open(Docks.Options.QUERY_DOCK)


func _on_templates_count_documents_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.set_code(Templates.COUNT_DOCUMENTS)


func _on_templates_find_one_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.set_code(Templates.FIND_ONE)


func _on_templates_find_many_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.set_code(Templates.FIND_MANY)


func _on_templates_insert_one_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.set_code(Templates.INSERT_ONE)


func _on_templates_insert_many_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.set_code(Templates.INSERT_MANY)


func _on_templates_update_one_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.set_code(Templates.UPDATE_ONE)


func _on_templates_update_many_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.set_code(Templates.UPDATE_MANY)


func _on_templates_replace_one_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.set_code(Templates.REPLACE_ONE)


func _on_templates_create_index_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.set_code(Templates.CREATE_INDEX)


func _on_more_templates_copy_to_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.set_code(Templates.COPY_TO)


func _on_more_templates_copy_batch_to_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.set_code(Templates.COPY_BATCH_TO)


func _on_connections_pressed() -> void:
	docks.open(Docks.Options.CONNECTION_DOCK)


func _on_history_pressed() -> void:
	docks.open(Docks.Options.HISTORY_DOCK)


func _on_settings_pressed() -> void:
	docks.open(Docks.Options.SETTINGS_DOCK)
