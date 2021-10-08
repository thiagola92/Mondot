extends Node


const FOLDER = "res://images/icon_folder.svg"
const CONNECTION = "res://images/icon_signals.svg"
const DATABASE = "res://images/icon_cylinder.svg"
const FILE = "res://images/icon_file.svg"

const EXECUTE = "res://images/icon_play.svg"

const NEXT = "res://images/icon_arrow_right.svg"
const PREVIOUS = "res://images/icon_arrow_left.svg"

const VISIBILITY_HIDDEN = "res://images/icon_visibility_hidden.svg"
const VISIBILITY_VISIBLE = "res://images/icon_visibility_visible.svg"

const SUCCESS = "res://images/icon_check_mark.svg"
const FAIL = "res://images/icon_cross_mark.svg"

const REMOVE = "res://images/icon_cross_mark.svg"

const LOCK = "res://images/icon_lock.svg"
const UNLOCK = "res://images/icon_unlock.svg"


static func from(id : int):
	match id:
		MondotType.FOLDER:
			return load(FOLDER)
		MondotType.CONNECTION:
			return load(CONNECTION)
		MondotType.DATABASE:
			return load(DATABASE)
		MondotType.COLLECTION:
			return load(FILE)
	
	return null
