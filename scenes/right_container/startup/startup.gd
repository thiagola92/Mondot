extends MarginContainer

func _ready():
	$HTTPRequest.request("https://thiagola92.github.io/utility/mongodot/startup.html")


func _on_HTTPRequest_request_completed(result : int, response_code : int, headers : PoolStringArray, body : PoolByteArray):
	if result == OK and response_code == 200:
		$Text.bbcode_text = body.get_string_from_utf8()
