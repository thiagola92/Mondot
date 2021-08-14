extends TextEdit


func _ready():
	add_color_override("font_color", Color("#9CDCFE"))
	add_color_override("number_color", Color("#B5CEA8"))
	add_color_override("function_color", Color("#DCDCAA"))
	add_color_override("member_variable_color", Color("#9CDCFE"))
	
	add_keywords_color(['def', 'class'], Color("#569CD6"))
	add_keywords_color([
		'from', 'import',
		'if', 'else', 'elif',
		'return',
		'while', 'for', 'in',
		'try', 'except', 'as', 'finally'
	], Color("#C586C0"))
	
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
