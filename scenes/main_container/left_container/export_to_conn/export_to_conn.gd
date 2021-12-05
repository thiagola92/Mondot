extends WindowDialog


signal export_requested(uri, db, code)


var source : Dictionary


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()


func setup(_source : Dictionary, root : TreeItem):
	source = _source
	
	$Container/Table.clear()
	$Container/Settings.setup(
		TreeItemKit.export_node(root).get("children")
	)
	
	_add_lines()
	popup_centered()


func _add_lines():
	match source["__type__"]:
		MondotType.COLLECTION:
			_add_collection_line(source["db"], source["name"])
		MondotType.DATABASE:
			$PythonWatcher.run(DatabaseCode.list_collection_names(), source["uri"], source["name"], 1000)


func _add_collection_line(source_db : String, source_col : String):
	$Container/Table.add_line(source_db, source_col, source_db, source_col)


func _on_PythonWatcher_output(result : GenericResult, _kwargs : Dictionary):
	if result.error:
		return Alert.message(result.error_string)
	_add_collections_lines(result.result)


func _add_collections_lines(collections : Array):
	for col in collections:
		_add_collection_line(source["name"], col)


func _on_Start_pressed():
	var code = _get_export_code()
	
	_request_export(code)
	hide()


func _get_export_code() -> String:
	var columns = $Container/Table.get_columns()
	var source_dbs = columns[0]
	var source_cols = columns[1]
	var target_uri = $Container/Settings.selected["uri"]
	var target_dbs = columns[2]
	var target_cols = columns[3]
	
	return MondotBeautifier.beautify_code([
		ImportCode.import_mongoclient(),
		DatabaseCode.copy_database(source_cols, target_uri, target_dbs, target_cols)
	])


func _request_export(code : String):
	match source["__type__"]:
		MondotType.COLLECTION:
			emit_signal("export_requested", source["uri"], source["db"], code)
		MondotType.DATABASE:
			emit_signal("export_requested", source["uri"], source["name"], code)


func _on_Cancel_pressed():
	hide()
