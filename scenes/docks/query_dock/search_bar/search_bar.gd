class_name SearchBar
extends HFlowContainer


@export var text_edit: TextEdit

@export var search_text: LineEdit

@export var counter: Label

# How many times the text searched appears.
var occurrences_count: int = 0:
	set(v):
		counter.text = str(v)
		occurrences_count = v


func _ready() -> void:
	hide()


func count_occurrences(text: String) -> void:
	occurrences_count = 0
	
	var text_pos: Vector2i = text_edit.search(text, text_edit.SEARCH_MATCH_CASE, 0, 0)
	
	if text_pos.x == -1:
		return
	
	occurrences_count += 1
	var previous_pos: Vector2i = text_pos
	var start_pos: Vector2i = next_position(text_pos)
	
	while start_pos.x != -1:
		text_pos = text_edit.search(text, text_edit.SEARCH_MATCH_CASE, start_pos.y, start_pos.x)
		
		if is_search_looping(previous_pos, text_pos):
			break
		
		occurrences_count += 1
		previous_pos = text_pos
		start_pos = next_position(text_pos)


func is_search_looping(smaller_pos: Vector2i, bigger_pos: Vector2i) -> bool:
	if bigger_pos.y > smaller_pos.y:
		return false
	elif bigger_pos.x > smaller_pos.x:
		return false
	return true


## Get the position after moving forward one character.
## [br]
## Return [code]Vector2i(-1, -,1)[/code] when not possible.
func next_position(pos: Vector2i) -> Vector2i:
	if pos.x + 1 < text_edit.get_line(pos.y).length():
		return Vector2i(pos.x + 1, pos.y)
	
	if pos.y + 1 < text_edit.get_line_count():
		return Vector2i(0, pos.y + 1)
	
	return Vector2i(-1, -1)


## Get the position after moving back one character.
## [br]
## Return [code]Vector2i(-1, -,1)[/code] when not possible.
func previous_position(pos: Vector2i) -> Vector2i:
	if pos.x - 1 >= 0:
		return Vector2i(pos.x - 1, pos.y)

	if pos.y - 1 >= 0:
		return Vector2i(
			text_edit.get_line(pos.y - 1).length(),
			pos.y - 1
		)

	return Vector2i(-1, -1)


func _on_search_text_text_changed(text: String) -> void:
	count_occurrences(text)


func _on_next_pressed() -> void:
	pass


func _on_previous_pressed() -> void:
	pass
