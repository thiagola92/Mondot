class_name WarningBar
extends HFlowContainer


@export var message_line: LineEdit


func show_message(message: String):
	message_line.text = message
	show()


func hide_message():
	message_line.text = ""
	hide()
