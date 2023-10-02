class_name Docks
extends VBoxContainer


enum Options {
	CONNECTION_DOCK,
	HISTORY_DOCK,
	QUERY_DOCK,
	SETTINGS_DOCK,
}

const QueryScene: PackedScene = preload("res://scenes/docks/query_dock/query_dock.tscn")

const HistoryScene: PackedScene = preload("res://scenes/docks/history_dock/history_dock.tscn")

const ConnectionScene: PackedScene = preload("res://scenes/docks/connection_dock/connection_dock.tscn")

const SettingsScene: PackedScene = preload("res://scenes/docks/settings_dock/settings_dock.tscn")

@export var docks_container: TabContainer

@export var docks_tab: TabBar


func _ready():
	GlobalRef.docks = self
	replicate_tabs()


func replicate_tabs() -> void:
	docks_tab.clear_tabs() # make sure that have zero tabs
	
	for dock in docks_container.get_children():
		docks_tab.add_tab(dock.DOCK_NAME)


func open(dock: Options) -> Node:
	match dock:
		Options.QUERY_DOCK:
			return new_dock(QueryScene)
		Options.HISTORY_DOCK:
			return focus_dock(HistoryDock, HistoryScene)
		Options.CONNECTION_DOCK:
			return focus_dock(ConnectionDock, ConnectionScene)
		Options.SETTINGS_DOCK:
			return focus_dock(SettingsDock, SettingsScene)
	return null


func new_dock(scene: PackedScene) -> Node:
	var dock: Node = scene.instantiate()
	var index: int = docks_container.get_child_count()
	
	docks_container.add_child(dock)
	docks_container.current_tab = index
	docks_tab.add_tab(dock.DOCK_NAME)
	docks_tab.current_tab = index
	
	return dock


func focus_dock(script: Script, scene: PackedScene) -> Node:
	var docks: Array[Node] = docks_container.get_children()

	for i in range(docks.size()):
		if docks[i].get_script() == script:
			docks_container.current_tab = i
			docks_tab.current_tab = i
			return docks[i]
	
	return new_dock(scene)


func remove_tab(tab: int) -> void:
	docks_container.get_child(tab).queue_free()
	docks_tab.remove_tab(tab)


func _on_docks_tab_tab_changed(tab) -> void:
	docks_container.current_tab = tab


func _on_docks_tab_tab_close_pressed(tab) -> void:
	remove_tab(tab)


func _on_docks_tab_active_tab_rearranged(idx_to) -> void:
	var c = docks_container.get_child(docks_container.current_tab)
	docks_container.move_child(c, idx_to)


func _on_docks_tab_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 3 and event.pressed == false:
			var tab = docks_tab.get_tab_idx_at_point(event.position)
			
			if tab >= 0:
				remove_tab(tab)
	
