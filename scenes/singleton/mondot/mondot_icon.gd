extends Node


static func from(id : int) -> Texture:
	match id:
		MondotType.FOLDER:
			return Icon.from("res://images/icon_folder.svg")
		MondotType.CONNECTION:
			return Icon.from("res://images/icon_signals.svg")
		MondotType.DATABASE:
			return Icon.from("res://images/icon_cylinder_shape.svg")
	
	return null
