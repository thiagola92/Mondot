class_name SettingsTag
extends Button

enum TagType {
	NOW = 0,
	NEW,
	RESTART,
}

@export var type: TagType

var tags: Array[Tag] = [
	Tag.new("Now", "This configuration will be applied right now."),
	Tag.new("All docks", "This configuration will be applied to new things."),
	Tag.new("On restart", "This configuration will be applied after restarting."),
]


func _ready() -> void:
	var tag: Tag = tags[type]
	text = tag.text
	tooltip_text = tag.tooltip


class Tag:
	var text: String
	var tooltip: String
	
	func _init(t1: String, t2: String) -> void:
		self.text = t1
		self.tooltip = t2
