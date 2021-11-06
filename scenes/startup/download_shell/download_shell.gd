extends AcceptDialog


var bin_dir = "bin/"


func _ready():
	DirectoryKit.create_directory(bin_dir)
	
	if DirectoryKit.is_directory_empty(bin_dir):
		pass
