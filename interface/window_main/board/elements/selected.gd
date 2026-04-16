extends Sprite2D

func _ready() -> void:
	region_rect.size = Vector2(Global.TILE_SIZE, Global.TILE_SIZE)

func _on_element_select(pos: Vector2i) -> void:
	var element: int = Global.data.elements[pos]
	var element_texture: Vector2 = Global.to_texture(element)
	
	region_rect.position = element_texture * Global.TILE_SIZE
	position = (Vector2(pos) + Vector2(0.5, 0.5)) * Global.TILE_SIZE
	visible = true
	
func _on_element_cancel() -> void:
	visible = false

func _on_target_select(_pos: Vector2i, _path: PackedVector2Array) -> void:
	visible = false
