class_name PopupMenuUtility
extends Node


## Get the menu's index containing the metadata.
## [br]Returns -1 if not founded.
static func get_metadata_index(menu: PopupMenu, metadata) -> int:
	for i in range(menu.item_count):
		if menu.get_item_metadata(i) == metadata:
			return i
	return -1


## Return the metadata from all items in the [PopupMenu] that are checked.
static func get_checked_metadata(menu: PopupMenu) -> Array:
	var metadatas: Array = []
	
	for i in menu.item_count:
		if menu.is_item_checked(i):
			metadatas.append(menu.get_item_metadata(i))
	
	return metadatas


## Return the text from all items in the [PopupMenu] that are checked.
static func get_checked_texts(menu: PopupMenu) -> Array[String]:
	var texts: Array[String] = []
	
	for i in range(menu.item_count):
		if menu.is_item_checked(i):
			texts.append(menu.get_item_text(i))
	
	return texts


## Get the submenu for the respective index.
## [br]Return null in case no submenu is found.
static func get_submenu(menu: PopupMenu, index: int) -> PopupMenu:
	return menu.get_node(menu.get_item_submenu(index))
