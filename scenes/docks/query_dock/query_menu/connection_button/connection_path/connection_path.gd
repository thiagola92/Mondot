## Used to represent a path to a collection.
##
## While [ConnectionInfo] holds information about the URI and it can contain the database,
## sometimes is not the database that the user wants and
## it doesn't contain which collection the user wants.
## [br][br]
## MondotShell let you specify the database with [code]self.client["db_name"][/code] and collection 
## with [code]self.db["col_name"][/code] but the intetion with this class is to reduce how much the user
## have to write. This class let us send the collection name to MondotShell,
## and this give the user the option to use [code]self.col[/code].
class_name ConnectionPath
extends RefCounted


var connection_info: ConnectionInfo

var database: String

var collection: String


func _init(conn_info: ConnectionInfo, db: String = PythonArgs.DEFAULT_DB, col: String = PythonArgs.DEFAULT_COL) -> void:
	connection_info = conn_info
	database = db
	collection = col
