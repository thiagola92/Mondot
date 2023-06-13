class_name TemplatesButton
extends MenuButton


signal count_documents_selected

signal find_one_selected

signal find_many_selected

signal insert_one_selected

signal insert_many_selected

signal update_one_selected

signal update_many_selected

signal replace_one_selected

signal create_index_selected

@onready var menu: PopupMenu = get_popup()


func _ready() -> void:
	menu.index_pressed.connect(_on_menu_index_pressed)


func _on_menu_index_pressed(index: int) -> void:
	match index:
		1:
			count_documents_selected.emit()
		2:
			find_one_selected.emit()
		3:
			find_many_selected.emit()
		4:
			insert_one_selected.emit()
		5:
			insert_many_selected.emit()
		6:
			update_one_selected.emit()
		7:
			update_many_selected.emit()
		8:
			replace_one_selected.emit()
		9:
			create_index_selected.emit()
