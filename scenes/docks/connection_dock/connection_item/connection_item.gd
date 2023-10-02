class_name ConnectionItem
extends PanelContainer


const LOCK_LOCKED: Texture = preload("res://icons/lock_locked.svg")

const LOCK_UNLOCKED: Texture = preload("res://icons/lock_unlocked.svg")

const EYE_OPEN: Texture = preload("res://icons/eye_open.svg")

const EYE_CLOSE: Texture = preload("res://icons/eye_close.svg")

const LINK: Texture = preload("res://icons/link.svg")

const LINK_GREEN: Texture = preload("res://icons/link_green.svg")

const LINK_RED: Texture = preload("res://icons/link_red.svg")

@export var lock: Button

@export var delete_confirmation: ConfirmationDialog

@export var name_line: LineEdit

@export var uri_line: LineEdit

@export var uri_show: Button

@export var uri_test: Button

@export var python_onetime: PythonOnetime

@export var python_parser: PythonParser

var connection_info: ConnectionInfo:
	set(c):
		connection_info = c
		name_line.text = c.connection_name
		uri_line.text = c.connection_uri


func press_unlock() -> void:
	lock.button_pressed = true
	_on_lock_toggled(true)


func test_uri() -> void:
	var query := Templates.TEST_URI % connection_info.connection_uri
	
	uri_test.icon = LINK
	
	# PythonArgs is irrelevant, query doesn't use it information
	python_onetime.run(query, PythonArgs.new())


func _on_lock_toggled(button_pressed: bool) -> void:
	if button_pressed:
		lock.icon = LOCK_UNLOCKED
		name_line.editable = true
		uri_line.editable = true
	else:
		lock.icon = LOCK_LOCKED
		name_line.editable = false
		uri_line.editable = false
		uri_line.secret = true


func _on_delete_pressed() -> void:
	delete_confirmation.popup_centered()


func _on_confirmation_dialog_confirmed() -> void:
	queue_free()
	Connections.remove_connection(connection_info)


func _on_name_line_text_changed(new_name: String) -> void:
	connection_info.connection_name = new_name


func _on_uri_line_text_changed(new_uri: String) -> void:
	connection_info.connection_uri = new_uri
	test_uri()


func _on_uri_show_toggled(button_pressed) -> void:
	if button_pressed:
		uri_show.icon = EYE_OPEN
		uri_line.secret = false
	else:
		uri_show.icon = EYE_CLOSE
		uri_line.secret = true


func _on_uri_copy_pressed() -> void:
	DisplayServer.clipboard_set(connection_info.connection_uri)


func _on_uri_test_pressed() -> void:
	test_uri()


func _on_python_onetime_execution_finished(content: String) -> void:
	python_parser.parse(content)


func _on_python_parser_python_code_failed(code: int, message: String) -> void:
	uri_test.icon = LINK_RED


func _on_python_parser_parsing_finished(content: Variant) -> void:
	uri_test.icon = LINK_GREEN
