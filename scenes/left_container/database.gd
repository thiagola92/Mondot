extends Node


func _ready():
	pass


func _on_Connection_new_databases(tree, parent, databases):
	_add_databases(tree, parent, databases)


func _add_databases(tree : Tree, parent : TreeItem, databases : Array):
	for db in databases:
		_add_database(tree, parent, {
			"__type__": MondotType.DATABASE,
			"name": db
		})


func _add_database(tree : Tree, parent : TreeItem, database : Dictionary):
	var tree_item = tree.create_item(parent)
	
	tree_item.set_text(0, database["name"])
	tree_item.set_metadata(0, database)
	tree_item.set_icon(0, MondotIcon.from(MondotType.DATABASE))
