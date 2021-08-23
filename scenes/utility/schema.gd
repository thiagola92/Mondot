extends Node

static func validate(structure : Dictionary, schema : Dictionary):
	for key in schema.keys():
		var field = structure.get(key)
		
		if not typeof(field) in schema[key]:
			return GenericResult.new(
				ERR_INVALID_DATA,
				'Unexpected type %s in field "%s"' % [TypeOf.this(field), key]
			)
	
	return GenericResult.new()
