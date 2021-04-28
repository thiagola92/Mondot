extends Tree

enum {
	CONNECTION,
	FOLDER
}

var root


func _ready():
	root = create_item()


func create_folder(name):
	var item = create_item(root)
	item.set_text(0, name)
	item.set_metadata({
		'_type_': FOLDER,
		'name': name
	})
