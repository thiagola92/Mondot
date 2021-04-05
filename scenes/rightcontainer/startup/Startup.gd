extends MarginContainer

func _ready():
	$HTTPRequest.request("https://thiagola92.github.io/utility/mongodot/startup.html")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result == OK and response_code == 200:
		$StartupText.bbcode_text = body.get_string_from_utf8()
