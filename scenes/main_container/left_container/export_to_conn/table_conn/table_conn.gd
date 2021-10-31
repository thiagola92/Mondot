extends Panel


const headers = [
	"Source database",
	"Source collection",
	"Target database",
	"Target collection",
	"",
]


func _ready():
	clear()
	
	# For test purpose only
	if $"." in get_tree().get_root().get_children():
		add_line("source_database0", "source_collection0", "target_database0", "target_col0")
		add_line("source_database1", "source_collection1", "target_database1", "target_col1")
		add_line("source_database2", "source_collection2", "target_database2", "target_col2")


func clear():
	$Container/Grid.clean()
	$Container/Grid.add_headers(headers)


func add_line(source_db : String, source_col : String, target_db : String, target_col : String):
	var columns = [
		$Container/Grid.add_line_edit(source_db, false),
		$Container/Grid.add_line_edit(source_col, false),
		$Container/Grid.add_line_edit(target_db, true),
		$Container/Grid.add_line_edit(target_col, true)
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
			"source_db": get_child(index).text,
			"source_col": get_child(index + 1).text,
			"target_db": get_child(index + 2).text,
			"target_col": get_child(index + 3).text
		})
	
	return lines
