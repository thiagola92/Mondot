extends Node


func parse(conn : Dictionary):
	var connection = conn.duplicate(true)
	var generic_result = Schema.validate(connection, MondotSchema.CONNECTION)
	
	if generic_result.error == OK:
		generic_result.result = _get_connection_values(connection)

	return generic_result


func _get_connection_values(connection : Dictionary):
	return {
		"__type__": connection['__type__'],
		'name': connection['name'],
		'host': connection['host'] if connection.get('host') != null else '127.0.0.1',
		'port': connection['port'] if connection.get('port') != null else 27017,
	}
