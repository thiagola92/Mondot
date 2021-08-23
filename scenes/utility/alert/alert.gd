extends AcceptDialog


func _ready():
	pass


func message(text : String):
	dialog_text = text
	popup_centered()
	set_as_minsize()
