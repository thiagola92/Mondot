extends Node


func parse(conn : Dictionary):
	var connection = conn.duplicate(true)
	var generic_result = Schema.validate(connection, MondotSchema.FOLDER)
	
	if generic_result.error == OK:
		generic_result.result = _get_folder_values(connection)

	return generic_result


func _get_folder_values(folder : Dictionary):
	return {
		'__type__': folder['__type__'],
		'name': folder['name'],
		'connections': folder['connections'],
	}
