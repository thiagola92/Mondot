class_name ResultJSON
extends TextEdit


var json: Variant:
	set(j):
		text = JSON.stringify(j, "    ")
		json = j
