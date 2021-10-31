extends HBoxContainer


var connection : Dictionary


func setup(connections : Array):
	$Connection.clear()
	
	connection = connections[0]
	_load_connections(connections)
	
	show()


func _load_connections(connections : Array):
	for index in range(connections.size()):
		$Connection.add_item(connections[index]["name"], index)
		$Connection.set_item_metadata(index, connections[index])


func _on_Connection_item_selected(index : int):
	connection = $Connection.get_item_metadata(index)
