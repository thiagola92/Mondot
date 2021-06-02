extends AcceptDialog


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()


func _on_Details_meta_clicked(meta : String):
	OS.shell_open(meta)
