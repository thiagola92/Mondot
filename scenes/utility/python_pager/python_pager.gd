extends Node

# PythonPager creates the concept navegating between pages of Mondot Shell
# and controls whenever you should or not navegate to the next/previous page.


var error
var current_page
var desired_page


func _ready():
	pass


func run(
		code : String,
		uri : String,
		db : String,
		page_size : int = 20
	):
	
	error = OK
	current_page = 1
	desired_page = 1
	
	$Python.run(code, uri, db, page_size)


func read_current_page() -> GenericResult:
	var output = $Python.read_output(current_page)
	var result = MondotPython.parse_output(output)
	
	error = result.error
	
	return result


func request_next_page() -> bool:
	if _is_waiting_desired_page() or _is_on_last_page():
		return false
		
	desired_page = current_page + 1
	
	if not _desired_page_exists():
		$Python.request_next_output()
	
	return true


func request_previous_page() -> bool:
	if _is_on_first_page():
		return false
		
	desired_page = current_page - 1
	
	return true


func gone_to_desired_page() -> bool:
	if not _desired_page_exists():
		return false
	
	# Once it change page, you shouldn't be able to request
	# more pages before knowing if the current page is OK.
	# Reading the current page will update this flag with the current status.
	current_page = desired_page
	error = ERR_CANT_ACQUIRE_RESOURCE
	
	return true


func kill_current_execution():
	$Python.kill_current_execution()


func _is_waiting_desired_page():
	return desired_page != current_page


func _is_on_last_page():
	return error != OK


func _desired_page_exists() -> bool:
	return $Python.output_exists(desired_page)


func _is_on_first_page():
	return current_page == 1
