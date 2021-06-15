extends WindowDialog


signal item_selected(item)


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()


func _on_Tree_item_activated():
	var item = $Container/Tree.get_selected()
	
	emit_signal("item_selected", item)
	
	hide()
