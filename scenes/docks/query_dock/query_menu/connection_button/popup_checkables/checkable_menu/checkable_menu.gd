class_name CheckableMenu
extends HBoxContainer


## Emitted when the checkbox is checked.
signal checked

## Emitted when the checkbox is unchecked.
signal unchecked

const ARROW_ICON: Texture = preload("res://icons/arrow_right.svg")

const HOURGLASS_ICON: Texture = preload("res://icons/hourglass.svg")

@export var checkbox: CheckBox

@export var button: Button

## Menu created when the user check the checkbox and
## showed when the user press/hover the button.
var menu: PopupCheckables

## If [code]true[/code], checkbox is checked.
var is_checked: bool:
	get:
		return checkbox.button_pressed

## Button text.
var text: String:
	set(t):
		button.text = t
	get:
		return button.text


## Set current menu to be used. Passing null will remove current [member menu].[br]  
## [br]
## - Free current [member menu][br]
## - Add new menu as child, so destroying this node will free the menu too[br]
## - Set new menu as current [member menu].
func set_menu(m: PopupCheckables) -> void:
	if menu:
		menu.queue_free()
	
	if m:
		add_child(m)
	
	menu = m
	
	update_icon()


func update_icon() -> void:
	if is_checked and not menu:
		button.icon = HOURGLASS_ICON
	elif is_checked and menu:
		button.icon = ARROW_ICON
	else:
		button.icon = null


## Show the menu which the checkbox turn on/off.
func show_menu() -> void:
	if menu and not menu.visible:
		# If you were to use the normal position/global_position,
		# you would receive something close to zero.
		# This happens because this measures are relative to window
		# and you are inside another popup (that is a window).
		var window_position = get_window().position
		
		menu.popup_on_position(
			Vector2(
				window_position.x + global_position.x + size.x + 8,
				window_position.y + global_position.y
			)
		)


func _on_button_pressed() -> void:
	show_menu()


func _on_button_mouse_entered() -> void:
	show_menu()


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		update_icon()
		checked.emit()
	else:
		set_menu(null)
		unchecked.emit()
