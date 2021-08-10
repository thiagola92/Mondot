extends Node

static func validate(structure : Dictionary, schema : Dictionary):
	var generic_result = GenericResult.duplicate()
	
	for key in schema.keys():
		var field = structure.get(key)
		
		if not typeof(field) in schema[key]:
			generic_result.error = ERR_INVALID_DATA
			generic_result.error_string = 'Unexpected type %s in field "%s"' % [
				TypeOf.this(field), key
			]
			
			# Don't wait the loop finish to return error
			return generic_result
	
	return generic_result
