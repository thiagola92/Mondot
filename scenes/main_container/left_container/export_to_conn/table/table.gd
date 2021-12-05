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
	
	# Remove button need to know the childs to remove when pressed
	$Container/Grid.add_remove_button(columns)


func get_columns() -> Array:
	var columns = $Container/Grid.columns
	var child_count = $Container/Grid.get_child_count()
	
	var source_dbs = []
	var source_cols = []
	var target_dbs = []
	var target_cols = []
	
	for index in range(columns, child_count, columns):
		source_dbs.append(_grid_child(index).text)
		source_cols.append(_grid_child(index + 1).text)
		target_dbs.append(_grid_child(index + 2).text)
		target_cols.append(_grid_child(index + 3).text)
	
	return [source_dbs, source_cols, target_dbs, target_cols]


func _grid_child(index : int) -> Node:
	return $Container/Grid.get_child(index)
