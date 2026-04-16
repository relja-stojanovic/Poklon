extends TileMapLayer

func _ready() -> void:
	Global.data.preview_changed.connect(_on_preview_changed)
	call_deferred("_on_preview_changed", Global.data)
	
func _on_preview_changed(data: GameData) -> void:
	for i in range(data.spawn_amount):
		var element: int = data.preview[i]
		var texture: Vector2i = Global.to_texture(element)
		var pos: Vector2i = Vector2i(i, 0)
		set_cell(pos, 0, texture)
