extends AcceptDialog


func _ready():
	# For test purpose only
	if get_tree().get_root().get_child(0) == $".":
		popup_centered()


func _on_Details_meta_clicked(meta : String):
	OS.shell_open(meta)
