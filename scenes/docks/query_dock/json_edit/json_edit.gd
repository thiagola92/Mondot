class_name JSONEdit
extends TextEdit


var json: Variant:
	set(j):
		text = JSON.stringify(j, "    ")
		json = j
