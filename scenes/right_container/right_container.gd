extends VBoxContainer

const startup = preload("res://scenes/right_container/startup/Startup.tscn")
const contents = []


func _ready():
	add_tab("Startup", startup.instance())


func add_tab(name : String, content : Node):
	_add_tab(name, content)
	
	if _exist_only_one_tab():
		_change_to_tab(0)


func _add_tab(name : String, content):
	contents.append(content)
	$Tabs.add_tab(name)


func _exist_only_one_tab():
	return len(contents) == 1


func _change_to_tab(tab : int):
	$Tabs.current_tab = tab
	$Tabs.emit_signal("tab_changed", tab)


func _remove_panel_content():
	if $Panel.get_child_count() > 0:
		$Panel.remove_child($Panel.get_child(0))


func _add_panel_content(content):
	$Panel.add_child(content)


func _remove_tab(tab : int):
	$Tabs.remove_tab(tab)
	contents.remove(tab)


func _exist_others_tabs():
	return len(contents) > 0


func _reposition_content(idx_from : int, idx_to : int):
	var content = contents[idx_from]
	contents.remove(idx_from)
	contents.insert(idx_to, content)


func _on_Tabs_tab_changed(tab : int):
	_remove_panel_content()
	_add_panel_content(contents[tab])


func _on_Tabs_tab_close(tab : int):
	_remove_panel_content()
	_remove_tab(tab)
	
	if _exist_others_tabs():
		_change_to_tab($Tabs.current_tab)


func _on_Tabs_reposition_active_tab_request(idx_to : int):
	_reposition_content($Tabs.current_tab, idx_to)
