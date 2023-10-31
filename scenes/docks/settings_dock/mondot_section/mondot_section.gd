class_name MondotSection
extends VBoxContainer


const THEME_RES_DIR = "res://themes"

@export var mondot_theme: OptionButton


func _ready() -> void:
	update_theme_options()
	update_theme_selected()


func update_theme_options() -> void:
	var dir = DirAccess.open(THEME_RES_DIR)
	
	if not dir:
		return print_debug("Fail to open theme directory.")
	
	mondot_theme.clear()
	
	for filename in dir.get_files():
		if filename.ends_with(".tres"):
			mondot_theme.add_item(filename.trim_suffix(".tres"))


func update_theme_selected() -> void:
	var theme_name = get_tree().root.theme.resource_path.get_file().trim_suffix(".tres")
	var index = find_item_with_text(theme_name)
	
	if index < 0:
		return
	
	mondot_theme.select(index)


func find_item_with_text(text: String) -> int:
	for index in mondot_theme.item_count:
		if mondot_theme.get_item_text(index) == text:
			return index
	return -1


func _on_theme_item_selected(index: int) -> void:
	Settings.theme = mondot_theme.get_item_text(index)
