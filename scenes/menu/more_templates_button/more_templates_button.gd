class_name MoreTemplatesButton
extends MenuButton


signal copy_to_selected

signal copy_batch_to_selected

@onready var menu: PopupMenu = get_popup()


func _ready() -> void:
	menu.index_pressed.connect(_on_menu_index_pressed)


func _on_menu_index_pressed(index: int) -> void:
	match index:
		1:
			copy_to_selected.emit()
		2:
			copy_batch_to_selected.emit()
