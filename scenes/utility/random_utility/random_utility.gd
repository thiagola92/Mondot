class_name RandomUtility


## Returns a pseudo-random ASCII string with size `length` where characters are
## inside the interval `from` and `to` (inclusive).
static func rands_ascii(length: int, from: int, to: int) -> String:
	var byte_array: PackedByteArray = PackedByteArray()
	
	for p in range(1, length):
		byte_array.append(randi_range(from, to))
	
	return byte_array.get_string_from_ascii()
