class_name MondotSection
extends VBoxContainer


const THEME_RES_DIR = "res://themes"

@export var mondot_theme: OptionButton


func _ready() -> void:
	update_theme_options()


func update_theme_options() -> void:
	var dir = DirAccess.open(THEME_RES_DIR)
	
	if not dir:
		return print_debug("Fail to open theme directory.")
	
	mondot_theme.clear()
	
	for filename in dir.get_files():
		var theme = load("%s/%s" % [THEME_RES_DIR, filename])
		
		if theme is Theme:
			mondot_theme.add_item(filename.trim_suffix(".tres"))
			mondot_theme.set_item_metadata(mondot_theme.item_count - 1, theme)


func _on_theme_item_selected(index: int) -> void:
	Settings.theme = mondot_theme.get_item_metadata(index)
