extends Sprite2D

signal finished(path: PackedVector2Array)

func _ready() -> void:
	region_rect.size = Vector2(Global.TILE_SIZE, Global.TILE_SIZE)

func _on_target_select(pos: Vector2i, path: PackedVector2Array) -> void:
	var element: int = Global.data.elements[pos]
	var element_texture: Vector2 = Global.to_texture(element)
	
	region_rect.position = element_texture * Global.TILE_SIZE
	finished.emit(path)
