class_name Menu
extends VBoxContainer


@export var docks: Docks


func _on_query_pressed() -> void:
	docks.open(Docks.Options.QUERY_DOCK)


func _on_templates_count_documents_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.query_code.text = Templates.COUNT_DOCUMENTS


func _on_templates_find_one_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.query_code.text = Templates.FIND_ONE


func _on_templates_find_many_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.query_code.text = Templates.FIND_MANY


func _on_templates_insert_one_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.query_code.text = Templates.INSERT_ONE


func _on_templates_insert_many_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.query_code.text = Templates.INSERT_MANY


func _on_templates_update_one_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.query_code.text = Templates.UPDATE_ONE


func _on_templates_update_many_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.query_code.text = Templates.UPDATE_MANY


func _on_templates_replace_one_selected() -> void:
	var query_dock: QueryDock = docks.open(Docks.Options.QUERY_DOCK)
	query_dock.query_code.text = Templates.REPLACE_ONE


func _on_connections_pressed() -> void:
	docks.open(Docks.Options.CONNECTION_DOCK)


func _on_history_pressed() -> void:
	docks.open(Docks.Options.HISTORY_DOCK)


func _on_settings_pressed() -> void:
	docks.open(Docks.Options.SETTINGS_DOCK)
