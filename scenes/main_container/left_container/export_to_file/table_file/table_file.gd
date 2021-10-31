extends Panel


const headers = [
	"Source database",
	"Source collection",
	"Target file",
	"",
]


func _ready():
	clear()
	
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		add_line("source_database0", "source_collection0", "target_file0")
		add_line("source_database1", "source_collection1", "target_file1")
		add_line("source_database2", "source_collection2", "target_file2")


func clear():
	$Container/Grid.clean()
	$Container/Grid.add_headers(headers)


func add_line(db : String, collection : String, target : String):
	var columns = [
		$Container/Grid.add_line_edit(db, false),
		$Container/Grid.add_line_edit(collection, false),
		$Container/Grid.add_line_edit(target, true)
	]
	
	for column in columns:
		$Container/Grid.add_child(column)
	
	# Remove button need to know the childs to remove when pressed
	$Container/Grid.add_remove_button(columns)


func get_lines():
	var lines = []
	var columns = $Container/Grid.columns
	var child_count = $Container/Grid.get_child_count()
	
	for index in range(columns, child_count, columns):
		lines.append({
			"db": get_child(index).text,
			"col": get_child(index + 1).text,
			"file": get_child(index + 2).text
		})
	
	return lines
