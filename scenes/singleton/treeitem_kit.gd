extends Node


func create_node(tree : Tree, parent : TreeItem, metadata : Dictionary):
	var child = tree.create_item(parent)
	child.set_text(0, metadata["name"])
	child.set_metadata(0, metadata)
	
	if metadata["__type__"] == MondotType.FOLDER:
		for item in metadata.get("connections", []):
			create_node(tree, child, item)
		
		var _erased = metadata.erase("connections")
	
	child.set_icon(0, MondotIcon.from(metadata["__type__"]))
	tree.scroll_to_item(child)


func move_node_to_new_parent(tree : Tree, node : TreeItem, new_parent : TreeItem):
	create_node(tree, new_parent, export_node(node))
	node.get_parent().remove_child(node)


func export_node(node : TreeItem) -> Dictionary:
	var metadata = node.get_metadata(0).duplicate(true)
	
	if metadata["__type__"] == MondotType.FOLDER:
		metadata["connections"] = export_children(node)
	
	return metadata


func export_children(node : TreeItem) -> Array:
	var children = []
	var child = node.get_children()
	
	while child:
		children.append(export_node(child))
		child = child.get_next()
	
	return children


func is_node_inside_parent(node : TreeItem, parent : TreeItem) -> bool:
	var child = parent.get_children()
	
	while child:
		if child == node:
			return true
			
		if is_node_inside_parent(node, child):
			return true
		
		child = child.get_next()
	
	return false
