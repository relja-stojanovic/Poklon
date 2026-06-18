extends Control

@export var filename: String = "icon128x128"

func _ready() -> void:
	await RenderingServer.frame_post_draw
	var viewport = $SubViewportContainer/SubViewport
	var image = viewport.get_texture().get_image()

	var error = image.save_png("res://assets/texture/%s.png"%filename)
	
	if error == OK:
		print("Icon saved successfully!")
	else:
		print("Error saving icon: ", error)
