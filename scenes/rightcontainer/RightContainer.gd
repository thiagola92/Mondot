extends VBoxContainer

const startup = preload("res://scenes/rightcontainer/startup/Startup.tscn")
const tabs = []


func _ready():
	add_tab("Startup", startup.instance())
	_on_Tabs_tab_changed(0)


func _on_Tabs_tab_changed(tab):
	$Panel.remove_child($Panel.get_child(0))
	$Panel.add_child(tabs[tab])


func _on_Tabs_tab_close(tab):
	$Panel.remove_child($Panel.get_child(0))
	$Tabs.remove_tab(tab)
	tabs.remove(tab)
	
	if $Tabs.current_tab > -1:
		_on_Tabs_tab_changed($Tabs.current_tab)


func add_tab(name, content):
	tabs.append(content)
	$Tabs.add_tab(name)
