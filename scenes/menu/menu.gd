class_name Menu
extends VBoxContainer


@export var docks: Docks


func _on_history_pressed():
	docks.open(Docks.Options.HISTORY_DOCK)


func _on_connections_pressed():
	docks.open(Docks.Options.CONNECTION_DOCK)


func _on_settings_pressed():
	docks.open(Docks.Options.SETTINGS_DOCK)


func _on_query_pressed():
	docks.open(Docks.Options.QUERY_DOCK)
