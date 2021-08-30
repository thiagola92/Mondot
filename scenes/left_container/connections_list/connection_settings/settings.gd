extends TabContainer


func _ready():
	pass


func get_host():
	return $Basic/Input/Host.text


func get_port():
	return $Basic/Input/Port.text


func get_username():
	return $Authentication/Input/Username.text


func get_password():
	return $Authentication/Input/Password.text


func get_db():
	return $Authentication/Input/Database.text


func get_scheme():
	match $Basic/Input/Connection.selected:
		0:
			return "mongodb"
		1:
			return "mongodb+srv"
	
	return "mongodb"


func get_options():
	var options = {}
	
	match $SSL/Input/SSL.selected:
		1:
			options["ssl"] = "true"
	
	return options


func set_basic(scheme : String, host : String, port : String):
	$Basic/Input/Host.text = host
	$Basic/Input/Port.text = port
	
	match scheme:
		"mongodb":
			$Basic/Input/Connection.select(0)
		"mongodb+srv":
			$Basic/Input/Connection.select(1)


func set_authentication(username : String, password : String, db : String):
	$Authentication/Input/Username.text = username
	$Authentication/Input/Password.text = password
	$Authentication/Input/Database.text = db


func set_ssl(options : Dictionary):
	match options.get("ssl"):
		"false":
			$SSL/Input/SSL.select(0)
		"true":
			$SSL/Input/SSL.select(1)	
