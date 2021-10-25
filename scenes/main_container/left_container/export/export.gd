extends WindowDialog


var source : Dictionary
var connections : Array


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()


func setup(_source : Dictionary, root : TreeItem):
	source = _source
	connections = TreeItemKit.export_node(root).get("children")
	
	$Container/ConnectionPath.setup(connections)
	
	popup_centered()


func _on_Target_item_selected(index):
	$Container/TableBG/TableContainer/Table.clear()
	
	match index:
		0:
			$Container/ConnectionPath.setup(connections)
		1:
			$Container/FolderPath.show()


func _on_ConnectionPath_database_selected():
	$Container/TableBG/TableContainer/Table.clear()
	
	_insert_on_table()


func _insert_on_table(extension : String = ""):
	match source["__type__"]:
		MondotType.COLLECTION:
			_insert_collection_on_table(source["db"], source["name"], extension)
		MondotType.DATABASE:
			_insert_database_on_table(source["uri"], source["name"], extension)
		MondotType.CONNECTION:
			pass


func _insert_collection_on_table(database : String, collection : String, extension : String = ""):
	$Container/TableBG/TableContainer/Table.add_line(
		database,
		collection,
		collection + extension
	)


func _insert_database_on_table(uri : String, database : String, extension : String = ""):
	$PythonWatcher.run(
		DatabaseCode.list_collection_names(),
		uri, database, 1000, 0,
		{"extension": extension}
	)


func _on_PythonWatcher_output(output, kwargs):
	output = parse_json(output)
	
	if output == null:
		return
	
	if output["error"] == true:
		return
	
	var extension = kwargs.get("extension", "")
	
	for collection in output["result"]:
		_insert_collection_on_table(source["name"], collection, extension)


func _on_FolderPath_dir_selected(dir):
	$Container/TableBG/TableContainer/Table.clear()
	
	_insert_on_table($Container/FolderPath.extension)


func _on_Start_pressed():
	var lines = $Container/TableBG/TableContainer/Table.get_lines()
	
	if $Container/ConnectionPath.visible:
		return _export_to_connection(lines)
	
	if $Container/FolderPath.visible:
		return _export_to_file(lines)


func _export_to_connection(lines : Array):
	var db_target = $Container/ConnectionPath.get_selected_database()
	var col_sources = []
	var col_targets = []
	
	for line in lines:
		col_sources.append(line["col_source"])
		col_targets.append(line["col_target"])
	
	var code = ImportCode.import_mongoclient() + \
			DatabaseCode.copy_database(col_sources, db_target["uri"], db_target["name"], col_targets)
	
	match source["__type__"]:
		MondotType.COLLECTION:
			$PythonWatcher2.run(code, source["uri"], source["db"])
		MondotType.DATABASE:
			$PythonWatcher2.run(code, source["uri"], source["name"])


func _export_to_file(lines : Array):
	pass
