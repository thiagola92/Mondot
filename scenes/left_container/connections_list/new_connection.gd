extends Button

var CreateConnection = preload("res://scenes/left_container/connections_list/create_connection/CreateConnection.tscn")


func _ready():
	pass


func _on_NewConnection_pressed():
	var window = CreateConnection.instance()
	add_child(window)
	window.popup_centered()
