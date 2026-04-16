extends SubViewport

func _ready() -> void:
	size = Vector2i(Global.data.spawn_amount, 1) * Global.TILE_SIZE
