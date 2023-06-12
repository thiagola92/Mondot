class_name PythonParser
extends Node


## Emitted when the parsed String is not a valid JSON String.
signal parsing_json_failed(line: int, message: String)

## Emitted when the data retrived from JSON is not a [Dictionary].
signal parsing_structure_failed(type: int)

## Emitted when Python code founds an error.
signal python_code_failed(code: int, message: String)

## Emitted when finish parsing without any problems.
signal parsing_finished(content: Variant)

## Emitted when parsing the last page from Python code.
## [br]Useful to show the user that there is no more pages after this.
## [br][b]Note[/b]: Occurs after [signal parsing_finished] so it doesn't disturbs the success behavior.
signal python_code_ended

var json: JSON = JSON.new()

var error_code: int = 0

var error_msg: String = ""

var result: Variant = ""

var number: int = 1


func parse_now(content: String) -> Variant:
	parse(content)
	
	if error_code in [OK, ERR_FILE_EOF]:
		return result
	return null


func parse(content: String) -> void:
	var error: Error = json.parse(content)
	
	if error:
		parsing_json_failed.emit(json.get_error_line(), json.get_error_message())
	elif not json.data is Dictionary:
		parsing_structure_failed.emit(typeof(json.data))
	else:
		extract()
		analyse()


func extract() -> void:
	error_code = json.data["error_code"]
	error_msg = json.data["error_msg"]
	result = json.data["result"]
	number = json.data["number"]


## [br][b]Note[/b]: Read [signal python_code_ended] to understand why is emitted after [signal parsing_finished].
func analyse() -> void:
	if not error_code in [OK, ERR_FILE_EOF]:
		python_code_failed.emit(error_code, error_msg)
		return
	
	parsing_finished.emit(result)
	
	## EOF is not an Error, just means that there is no more pages after this.
	if error_code == ERR_FILE_EOF:
		python_code_ended.emit()
