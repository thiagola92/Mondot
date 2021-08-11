extends VBoxContainer

var output_path = null


func _ready():
	hide()


func show_output(filepath : String):
	output_path = "%s_%s" % [filepath, $Menu/PageNumber.text]
	$Output.text = _read_file(output_path)
	
	show()


func _read_file(filepath):
	var file = File.new()
	
	file.open(filepath, File.READ)
	var content = file.get_as_text()
	file.close()
	
	return content


func _on_Refresh_pressed():
	$Output.text = _read_file(output_path)
