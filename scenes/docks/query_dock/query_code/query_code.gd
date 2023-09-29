class_name QueryCode
extends CodeEdit


var code_highlighter: CodeHighlighter = CodeHighlighter.new()


func _ready() -> void:
	add_colors()


## Add colors to keywords.
## [br][br]
## Gnome colors palette: [url]https://developer.gnome.org/hig/reference/palette.html[/url][br]
## Python types: [url]https://docs.python.org/3/library/stdtypes.html[/url]
func add_colors() -> void:
	code_highlighter.number_color = Color("#8ff0a4")
	code_highlighter.function_color = Color("#62a0ea")
	code_highlighter.member_variable_color = Color("#99c1f1")
	code_highlighter.symbol_color = Color("#deddda")
	
	# comment
	code_highlighter.add_color_region("#", "", Color("#77767b"), true)
	
	add_keywords_color([
		'def', 'class', 'lambda', # definition
		'self', # reference
		'True', 'False', 'None', # constant
		'and', 'or', 'not', # boolean operator
		'is', # comparison operator
		'in', # sequence operator
		'bool', # boolean type
		'int', 'float', 'complex', # numeric type
		'list', 'tuple', 'range', # sequence type
		'str', # text sequence type
		'bytes', 'bytearray', 'memoryview', # binary type
		'set', 'frozenset', # set type
		'dict', # mapping type
	], Color("#ffbe6f"))
	
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
	], Color("#dc8add"))
	
	add_color_regions([
		['"', '"'], # string
		["'", "'"], # string
		['"""', '"""'], # multiline string
		["'''", "'''"], # multiline string
	], Color("#f9f06b"))
	
	syntax_highlighter = code_highlighter


func add_keywords_color(keywords : Array, color : Color) -> void:
	for keyword in keywords:
		code_highlighter.add_keyword_color(keyword, color)


func add_color_regions(regions : Array, color : Color) -> void:
	for region in regions:
		code_highlighter.add_color_region(region[0], region[1], color)
