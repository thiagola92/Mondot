extends VBoxContainer

const startup = preload("res://scenes/right_container/startup/Startup.tscn")


func _ready():
	add_tab("Startup", startup.instance())


func add_tab(name : String, content : Node):
	_add_tab(name, content)
	_change_to_last_tab()


func _add_tab(name : String, content):
	$Panel.add_child(content)
	$TabsBg/Tabs.add_tab(name)


func _change_to_last_tab():
	var last_tab = $TabsBg/Tabs.get_tab_count() - 1
	_change_to_tab(last_tab)


func _change_to_tab(tab : int):
	if tab >= 0:
		$TabsBg/Tabs.current_tab = tab
		$TabsBg/Tabs.emit_signal("tab_changed", tab)


func _on_Tabs_tab_changed(tab : int):
	# The signal "tab_changed" doesn't tell the previous tab.
	# So we hide all contents before showing the new tab.
	_hide_all_panel_content()
	_show_panel_content(tab)


func _hide_all_panel_content():
	for child in $Panel.get_children():
		child.hide()


func _show_panel_content(tab : int):
	$Panel.get_child(tab).show()


func _on_Tabs_tab_close(tab : int):
	_remove_panel_content(tab)
	_remove_tab(tab)
	_change_to_last_tab()


func _remove_panel_content(tab : int):
	var child = $Panel.get_child(tab)
	child.queue_free()


func _remove_tab(tab : int):
	$TabsBg/Tabs.remove_tab(tab)


func _on_Tabs_reposition_active_tab_request(idx_to : int):
	var current_tab = $TabsBg/Tabs.current_tab
	_reposition_content(current_tab, idx_to)


func _reposition_content(idx_from : int, idx_to : int):
	var child = $Panel.get_child(idx_from)
	$Panel.move_child(child, idx_to)
