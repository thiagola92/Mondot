extends Node

class_name Type

const _table = {
	 0: 'TYPE_NIL',
	 1: 'TYPE_BOOL',
	 2: 'TYPE_INT',
	 3: 'TYPE_REAL',
	 4: 'TYPE_STRING',
	 5: 'TYPE_VECTOR2',
	 6: 'TYPE_RECT2',
	 7: 'TYPE_VECTOR3',
	 8: 'TYPE_TRANSFORM2D',
	 9: 'TYPE_PLANE',
	 10: 'TYPE_QUAT',
	 11: 'TYPE_AABB',
	 12: 'TYPE_BASIS',
	 13: 'TYPE_TRANSFORM',
	 14: 'TYPE_COLOR',
	 15: 'TYPE_NODE_PATH',
	 16: 'TYPE_RID',
	 17: 'TYPE_OBJECT',
	 18: 'TYPE_DICTIONARY',
	 19: 'TYPE_ARRAY',
	 20: 'TYPE_RAW_ARRAY',
	 21: 'TYPE_INT_ARRAY',
	 22: 'TYPE_REAL_ARRAY',
	 23: 'TYPE_STRING_ARRAY',
	 24: 'TYPE_VECTOR2_ARRAY',
	 25: 'TYPE_VECTOR3_ARRAY',
	 26: 'TYPE_COLOR_ARRAY',
	 27: 'TYPE_MAX',
}


func _ready():
	pass


func of(value) -> String:
	return _table[typeof(value)]
