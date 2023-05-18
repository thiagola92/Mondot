extends VBoxContainer


var query_args: PythonArgs

@onready var query_code: TextEdit = $QueryCode

@onready var datetime: Label = $QueryDetails/Datetime


func init(code: String, args: PythonArgs) -> void:
	query_code.text = code
	query_args = args
	datetime.text = Time.get_datetime_string_from_system(false, true)
