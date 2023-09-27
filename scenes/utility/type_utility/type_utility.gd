## Deals with type conversion that GDScript still doesn't make.
##
## Once GDScript let you make convertion in a easier way, delete this functions.
class_name TypeUtility
extends Node


static func to_array_string(array: Array) -> Array[String]:
	var array_string: Array[String] = []
	array_string.assign(array)
	return array_string
