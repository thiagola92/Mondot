extends WindowDialog

var base_size = rect_size


func _ready():
	# For test purpose only
#	if $"." in get_tree().get_root().get_children():
#		message("Test message")
	pass


func message(text : String):
	$Container/Message.text = text
	rect_size = base_size
	popup_centered()


func _on_Ok_pressed():
	hide()
