extends WindowDialog


var source : Dictionary


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()


func setup(_source : Dictionary):
	source = _source
	
	$Container/TableFile.clear()
	
	_add_lines()
	popup_centered()


func _on_Cancel_pressed():
	hide()


func _on_Start_pressed():
	var lines = $Container/TableFile.get_lines()
	var path = $Container/DirPath.get_folder_path()


func _add_lines():
	match source["__type__"]:
		MondotType.COLLECTION:
			_add_collection_line(source["db"], source["name"])
		MondotType.DATABASE:
			$PythonWatcher.run(DatabaseCode.list_collection_names(), source["uri"], source["name"], 1000)


func _add_collection_line(source_db : String, source_col : String):
	$Container/TableFile.add_line(source_db, source_col, source_col)


func _on_PythonWatcher_output(result : GenericResult, _kwargs : Dictionary):
	if result.error:
		return Alert.message(result.error_string)
	_add_collections_lines(result.result)


func _add_collections_lines(collections : Array):
	for col in collections:
		_add_collection_line(source["name"], col)
