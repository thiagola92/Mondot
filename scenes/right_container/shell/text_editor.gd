extends TextEdit


func _ready():
	add_color_override("font_color", Color("#9CDCFE"))
	add_color_override("number_color", Color("#B5CEA8"))
	add_color_override("function_color", Color("#DCDCAA"))
	add_color_override("member_variable_color", Color("#9CDCFE"))
	
	add_keywords_color(['def', 'class'], Color("#569CD6"))
	add_keywords_color([
		'from', 'import', # module
		'if', 'else', 'elif', # condition
		'while', 'for', 'continue', 'break', # loop
		'try', 'except', 'finally', 'raise', # exception
		'return', # function
		'async', 'await', # asynchronus
		'global', 'nonlocal', # scope
		'assert', # test
		'pass', 'as', 'del', 'with', # others
	], Color("#C586C0"))
	
	add_keywords_color([
		'True', 'False', 'None', # constant
		'and', 'or', 'is', 'in', 'not', # operator
		'lambda', # function
	], Color("#569CD6"))
	
	# Strings
	add_color_regions([
		['"', '"'],
		["'", "'"],
		['"""', '"""'],
		["'''", "'''"],
	], Color("#CE9178"))
	
	# Comment
	add_color_region('#', '\n', Color("#6A9955"), true)


func add_keywords_color(keywords : Array, color : Color):
	for keyword in keywords:
		add_keyword_color(keyword, color)


func add_color_regions(regions : Array, color : Color):
	for region in regions:
		add_color_region(region[0], region[1], color)
