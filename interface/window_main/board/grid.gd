extends ShaderSelector

func _ready() -> void:
	super()
	material.set_shader_parameter("grid_size", data.size)
