extends Button

var LoadUri = preload("res://scenes/leftcontainer/connections_list/load_uri/LoadUri.tscn")


func _ready():
	pass


func _create_window():
	var window = LoadUri.instance()
	add_child(window)
	window.connect("popup_hide", self, "_remove_children")


func _remove_children():
	for children in get_children():
		children.queue_free()


func _on_LoadUri_pressed():
	if get_child_count() == 0:
		_create_window()
	get_child(0).popup_centered()
