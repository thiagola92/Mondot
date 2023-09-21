## UI to display and interact with one [QueryInfo].
class_name HistoryItem
extends VBoxContainer


signal play_pressed

@export var query_code: TextEdit

@export var datetime: Label

## The [QueryInfo] containing all information that should be displayed in the UI.
var query_info: QueryInfo


func _ready():
	query_code.text = query_info.query_code
	datetime.text = query_info.datetime


func _on_delete_pressed():
	queue_free()
	Historic.remove_query(query_info)


func _on_play_pressed() -> void:
	GlobalRef.docks.open(Docks.Options.QUERY_DOCK)
