extends WindowDialog


var source : Dictionary


func _ready():
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		popup_centered()


func setup(_source : Dictionary, root : TreeItem):
	var connections = TreeItemKit.export_node(root).get("children")
	source = _source
	
	$Container/TableConn.clear()
	$Container/ConnectionPath.setup(connections)
	
	_add_lines()
	popup_centered()


func _on_Cancel_pressed():
	hide()


func _on_Start_pressed():
	pass # Replace with function body.


func _add_lines():
	match source["__type__"]:
		MondotType.COLLECTION:
			_add_collection_line(source["db"], source["name"])
		MondotType.DATABASE:
			$PythonWatcher.run(DatabaseCode.list_collection_names(), source["uri"], source["name"], 1000)


func _add_collection_line(source_db : String, source_col : String):
	$Container/TableConn.add_line(source_db, source_col, source_db, source_col)


func _on_PythonWatcher_output(output : String, kwargs : Dictionary):
	var parse_result = JSON.parse(output)
	
	if parse_result.error != OK:
		return
	
	var result = parse_result.result
	
	if result["error"] == true:
		return
	
	_add_collections_lines(result["result"])


func _add_collections_lines(collections : Array):
	for col in collections:
		_add_collection_line(source["name"], col)
