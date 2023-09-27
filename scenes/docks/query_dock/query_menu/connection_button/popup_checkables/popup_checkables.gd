class_name PopupCheckables
extends PopupPanel


const CheckableMenuScene: PackedScene = preload("res://scenes/docks/query_dock/query_menu/connection_button/popup_checkables/checkable_menu/checkable_menu.tscn")

const CheckableLabelScene: PackedScene = preload("res://scenes/docks/query_dock/query_menu/connection_button/popup_checkables/checkable_label/checkable_label.tscn")

@export var container: VBoxContainer


func _ready() -> void:
	visible = false


func popup_on_position(pos: Vector2) -> void:
	var minimum_size = container.get_minimum_size()
	popup_on_parent(Rect2(pos.x, pos.y, minimum_size.x + 32, minimum_size.y + 8))


func create_checkable_menu(text: String) -> CheckableMenu:
	var checkable_menu: CheckableMenu = CheckableMenuScene.instantiate() as CheckableMenu
	
	checkable_menu.text = text
	
	container.add_child(checkable_menu)
	
	return checkable_menu


func create_checkable_label(text: String) -> CheckableLabel:
	var checkable_label: CheckableLabel = CheckableLabelScene.instantiate() as CheckableLabel
	
	checkable_label.text = text
	
	container.add_child(checkable_label)
	
	return checkable_label


func find_checkable_menu_with_metadata(field: String, metadata: Variant) -> CheckableMenu:
	for child in container.get_children():
		if child is CheckableMenu:
			if child.get_meta(field) == metadata:
				return child
	return null


func find_checkable_menu_with_text(text: String) -> CheckableMenu:
	for child in container.get_children():
		if child is CheckableMenu:
			if child.text == text:
				return child
	return null


func find_checkable_label_with_text(text: String) -> CheckableLabel:
	for child in container.get_children():
		if child is CheckableLabel:
			if child.text == text:
				return child
	return null


func get_checked_children() -> Array[Node]:
	return container.get_children().filter(
		func(child):
			if child is CheckableLabel:
				return child.is_checked
			elif child is CheckableMenu:
				return child.is_checked
			return false
	)
