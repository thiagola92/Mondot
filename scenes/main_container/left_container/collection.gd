extends Node


signal shell_requested(uri, db, code, readonly)


func _ready():
	pass


func open_shell(uri : String, db : String, collection : String):
	var code = MondotBeautifier.beautify_code([
		CollectionCode.find(collection)
	])
	
	emit_signal("shell_requested", uri, db, code)


func show_collection_stats(uri : String, db : String, collection : String):
	var code = MondotBeautifier.beautify_code([
		CollectionCode.show_collection_stats(collection)
	])
	
	emit_signal("shell_requested", uri, db, code, true)


func drop_collection(uri : String, db : String, collection : String):
	var code = MondotBeautifier.beautify_code([
		CollectionCode.drop_collection(collection)
	])
	
	emit_signal("shell_requested", uri, db, code, true)


func move_collection(src_uri, src_db, src_col, dest_uri, dest_db):
	var code = MondotBeautifier.beautify_code([
		ImportCode.import_mongoclient(),
		CollectionCode.move_collection(src_col, dest_uri, dest_db, src_col)
	])
	
	emit_signal("shell_requested", src_uri, src_db, code, true, true)


func _on_Database_new_collections(tree, parent, collections):
	_add_collections(tree, parent, collections)


func _add_collections(tree : Tree, parent : TreeItem, collections : Array):
	var database = parent.get_metadata(0)
	
	for col in collections:
		_add_collection(tree, parent, {
			"__type__": MondotType.COLLECTION,
			"name": col,
			"uri": database["uri"],
			"db": database["name"],
		})


func _add_collection(tree : Tree, parent : TreeItem, collection : Dictionary):
	var tree_item = tree.create_item(parent)
	
	tree_item.set_text(0, collection["name"])
	tree_item.set_metadata(0, collection)
	tree_item.set_icon(0, MondotIcon.from(MondotType.COLLECTION))
