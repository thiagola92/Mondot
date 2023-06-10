class_name ConnectionItem
extends PanelContainer


@export var lock: Button

@export var name_line: LineEdit

@export var uri_line: LineEdit

@export var uri_show: Button

const LOCK_LOCKED: Texture = preload("res://icons/lock_locked.svg")

const LOCK_UNLOCKED: Texture = preload("res://icons/lock_unlocked.svg")

const EYE_OPEN: Texture = preload("res://icons/eye_open.svg")

const EYE_CLOSE: Texture = preload("res://icons/eye_close.svg")

var connection_info: ConnectionInfo:
	set(c):
		connection_info = c
		name_line.text = c.connection_name
		uri_line.text = c.connection_uri


func _on_lock_toggled(button_pressed):
	if button_pressed:
		lock.icon = LOCK_UNLOCKED
		name_line.editable = true
		uri_line.editable = true
	else:
		lock.icon = LOCK_LOCKED
		name_line.editable = false
		uri_line.editable = false
		uri_line.secret = true


func _on_delete_pressed():
	queue_free()
	Connections.remove_connection(connection_info)


func _on_name_line_text_changed(new_name: String) -> void:
	connection_info.connection_name = new_name


func _on_uri_line_text_changed(new_uri: String) -> void:
	connection_info.connection_uri = new_uri


func _on_uri_show_toggled(button_pressed):
	if button_pressed:
		uri_show.icon = EYE_OPEN
		uri_line.secret = false
	else:
		uri_show.icon = EYE_CLOSE
		uri_line.secret = true
