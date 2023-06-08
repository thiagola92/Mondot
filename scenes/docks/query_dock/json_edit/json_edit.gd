class_name JSONEdit
extends TextEdit


signal parser_failed(line: int, message: String)

var json: JSON = JSON.new()


func process_content(content: String) -> void:
	var error: Error = json.parse(content)
	
	if error:
		parser_failed.emit(json.get_error_line(), json.get_error_message())
		return
	
	print(json.data)
	text = content
