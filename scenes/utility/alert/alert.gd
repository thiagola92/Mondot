extends AcceptDialog

class_name Alert


func _ready():
	pass


func message(text : String):
	dialog_text = text
	popup_centered()
