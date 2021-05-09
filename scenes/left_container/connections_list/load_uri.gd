extends Button

var LoadUri = preload("res://scenes/left_container/connections_list/load_uri/LoadUri.tscn")


func _ready():
	pass


func _on_LoadUri_pressed():
	var window = LoadUri.instance()
	add_child(window)
	window.popup_centered()
