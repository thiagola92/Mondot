## Reference to others nodes on tree.
##
## Used when you are far away from the node that you want to use in the tree.
## [br][br]
## Always connect a [Callable] to the [signal Node.tree_exiting] so you can unset the variable
## when the node leaves the tree.
class_name GlobalReference
extends Node


static var docks: Docks = null:
	set(v):
		if v != null:
			v.tree_exiting.connect(
				func():
					GlobalReference.docks = null
			)
		docks = v
