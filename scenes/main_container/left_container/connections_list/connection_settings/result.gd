extends HBoxContainer


func _ready():
	pass


func set_uri(uri : String):
	$URI.text = uri


func show_uri():
	$URI.secret = false
	$View.icon = load("res://images/icon_GUI_visibility_visible.svg")


func hide_uri():
	$URI.secret = true
	$View.icon = load("res://images/icon_GUI_visibility_hidden.svg")


func _on_View_toggled(button_pressed):
	if button_pressed:
		show_uri()
	else:
		hide_uri()
