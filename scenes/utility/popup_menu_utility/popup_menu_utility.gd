class_name PopupMenuUtility
extends Node


## Get the menu's index containing the metadata.
## [br]Returns -1 if not founded.
static func get_metadata_index(metadata, menu: PopupMenu) -> int:
	for i in range(menu.item_count):
		if menu.get_item_metadata(i) == metadata:
			return i
	return -1


static func get_checked_texts(menu: PopupMenu) -> Array[String]:
	var texts: Array[String] = []
	
	for i in range(menu.item_count):
		if menu.is_item_checked(i):
			texts.append(menu.get_item_text(i))
	
	return texts


## Get the submenu for the respective index.
static func get_submenu(index: int, menu: PopupMenu) -> PopupMenu:
	return menu.get_node(menu.get_item_submenu(index))
