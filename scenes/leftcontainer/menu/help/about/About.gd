extends RichTextLabel


func _ready():
	pass


func _on_Details_meta_clicked(meta):
	OS.shell_open(meta)
