extends HBoxContainer


func _ready():
	pass


func set_uri(uri : String):
	$URI.text = uri


func show_uri():
	$URI.secret = false
	$View.icon = load(MondotIcon.VISIBILITY_VISIBLE)


func hide_uri():
	$URI.secret = true
	$View.icon = load(MondotIcon.VISIBILITY_HIDDEN)


func _on_View_toggled(button_pressed):
	if button_pressed:
		return show_uri()
	return hide_uri()


func _on_Copy_pressed():
	_copy_uri()


func _copy_uri():
	var uri = $URI.text
	OS.clipboard = uri
