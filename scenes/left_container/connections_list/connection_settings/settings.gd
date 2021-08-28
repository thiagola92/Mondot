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
	var selected = $SSL/Input/SSL.selected
	
	match selected:
		0:
			return "mongodb"
		1:
			return "mongodb+srv"
	
	return "mongodb"


func set_basic(host : String, port : String):
	$Basic/Input/Host.text = host
	$Basic/Input/Port.text = port


func set_authentication(username : String, password : String, db : String):
	$Authentication/Input/Username.text = username
	$Authentication/Input/Password.text = password
	$Authentication/Input/Database.text = db


func set_ssl(scheme : String):
	match scheme:
		"mongodb":
			$SSL/Input/SSL.selected = 0
		"mongodb+srv":
			$SSL/Input/SSL.selected = 1
