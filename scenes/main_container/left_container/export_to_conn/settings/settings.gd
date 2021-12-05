extends HBoxContainer


var selected : Dictionary


func setup(connections : Array):
	$Connections.clear()
	
	selected = connections[0]
	_load_connections(connections)
	
	show()


func _load_connections(connections : Array):
	for index in range(connections.size()):
		$Connections.add_item(connections[index]["name"], index)
		$Connections.set_item_metadata(index, connections[index])


func _on_Connections_item_selected(index : int):
	selected = $Connections.get_item_metadata(index)
