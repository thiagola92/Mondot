extends Node


func from(path : String):
	var texture = ImageTexture.new()
	var image = Image.new()
	
	image.load(path)
	texture.create_from_image(image)
	
	return texture
