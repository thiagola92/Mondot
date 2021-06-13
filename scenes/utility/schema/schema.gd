extends Node

static func is_valid(structure : Dictionary, schema : Dictionary):
	for key in schema.keys():
		if not typeof(structure.get(key)) in schema[key]:
			SchemaParseResult.error = ERR_INVALID_DATA
			SchemaParseResult.error_string = 'Unexpected type %s in field "%s"' % [
				TypeAsStr.of(structure.get(key)), key
			]
			
			return false
	return true
