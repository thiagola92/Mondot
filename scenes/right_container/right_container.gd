extends VBoxContainer

const startup = preload("res://scenes/right_container/startup/Startup.tscn")


func _ready():
	add_tab("Startup", startup.instance())


func add_tab(name : String, content : Node):
	_add_tab(name, content)


func _add_tab(name : String, content):
	$Panel.add_child(content)
	$TabsBg/Tabs.add_tab(name)
	_change_to_last_tab()


func _change_to_last_tab():
	var tab = $TabsBg/Tabs.get_tab_count() - 1
	
	_change_to_tab(tab)


func _change_to_tab(tab : int):
	if tab >= 0 and tab < $TabsBg/Tabs.get_tab_count():
		$TabsBg/Tabs.current_tab = tab


func _on_Tabs_tab_changed(_tab : int):
	# The signal "tab_changed" doesn't tell the previous tab.
	# So we hide all contents before showing the new tab.
	_hide_all_contents()
	_show_current_content()


func _hide_all_contents():
	for child in $Panel.get_children():
		child.hide()


func _show_current_content():
	var tab = $TabsBg/Tabs.current_tab
	
	_show_content(tab)


func _show_content(tab : int):
	if tab >= 0 and tab < $Panel.get_child_count():
		$Panel.get_child(tab).show()


func _on_Tabs_tab_close(tab : int):
	if _is_current_tab(tab):
		_try_change_to_an_adjacent_tab(tab)
	
	_remove_content(tab)
	_remove_tab(tab)


func _is_current_tab(tab : int) -> bool:
	return $TabsBg/Tabs.current_tab == tab


func _try_change_to_an_adjacent_tab(tab : int):
	# The "_change_to_tab" doesn't change if tab doesn't exists.
	# This give priority for the previous tab to be showed
	_change_to_tab(tab + 1)
	_change_to_tab(tab - 1)


func _remove_content(tab : int):
	$Panel.get_child(tab).hide()
	$Panel.get_child(tab).queue_free()


func _remove_tab(tab : int):
	$TabsBg/Tabs.remove_tab(tab)


func _on_Tabs_reposition_active_tab_request(idx_to : int):
	var current_tab = $TabsBg/Tabs.current_tab
	_reposition_content(current_tab, idx_to)


func _reposition_content(idx_from : int, idx_to : int):
	var child = $Panel.get_child(idx_from)
	$Panel.move_child(child, idx_to)
