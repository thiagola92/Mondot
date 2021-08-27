extends WindowDialog


signal item_selected(item)


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()


func _on_Tree_item_activated():
	var item = $Container/Tree.get_selected()
	var metadata = item.get_metadata(0)
	
	if metadata["__type__"] == MondotType.CONNECTION:
		emit_signal("item_selected", item)
		hide()
