extends Node


static func from(id : int):
	match id:
		MondotType.FOLDER:
			return load("res://images/icon_folder.svg")
		MondotType.CONNECTION:
			return load("res://images/icon_signals.svg")
		MondotType.DATABASE:
			return load("res://images/icon_cylinder_shape.svg")
		MondotType.COLLECTION:
			return load("res://images/icon_file.svg")
	
	return null
