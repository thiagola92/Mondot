class_name QueryHistory
extends Node


signal query_added(query_info: QueryInfo)

signal query_removed(query_info: QueryInfo)

signal queries_cleared

var queries: Array[QueryInfo] = []


## Import from file every queries informations.
func import() -> void:
	queries.append_array([
#		QueryInfo.new("asdf", PythonArgs.new()),
#		QueryInfo.new("123", PythonArgs.new()),
#		QueryInfo.new("xcv", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new()),
#		QueryInfo.new("5", PythonArgs.new())
	])


func add_query(code: String, args: PythonArgs) -> void:
	var query_info: QueryInfo = QueryInfo.new(code, args)
	queries.append(query_info)
	query_added.emit(query_info)
	
	export()


func remove_query(query_info: QueryInfo) -> void:
	queries.erase(query_info)
	query_removed.emit(query_info)
	
	export()


func clear_queries() -> void:
	queries = []
	queries_cleared.emit()
	
	export()


## Export to a file all queries informations.
func export() -> void:
	pass
