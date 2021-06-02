extends WindowDialog


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()
