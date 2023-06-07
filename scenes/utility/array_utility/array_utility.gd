class_name ArrayUtility


## Loop through an Array in reverse order and pass each item to the callback.
static func process_reversed(array: Array, callback: Callable) -> void:
	for i in array.size():
		callback.call(array[-i-1])
