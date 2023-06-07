class_name QueryInfo
extends RefCounted


## Python code used in query.
## [br][b]Note[/b]: User must be carefull to not put sensitive information here
## because no verification of sensitive data is made.
var query_code: String

## URIs are stored as hashes SHA256 for security.
var uris: Array[String] = []

var dbs: Array[String]

var page_size: int

var datetime: String


func _init(code: String, args: PythonArgs):
	query_code = code
	dbs = args.dbs
	page_size = args.page_size
	datetime = Time.get_datetime_string_from_system(false, true)
	
	for uri in args.uris:
		uris.append(uri.sha256_text())


func to_dict() -> Dictionary:
	return {
		"code": query_code,
		"uris": uris,
		"dbs": dbs,
		"page_size": page_size
	}
