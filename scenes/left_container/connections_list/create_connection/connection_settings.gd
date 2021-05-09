extends TabContainer


func _ready():
	pass


func get_host() -> String:
	return $Basic/HostContainer/HostInput.text


func get_port() -> String:
	return $Basic/PortContainer/PortInput.text
