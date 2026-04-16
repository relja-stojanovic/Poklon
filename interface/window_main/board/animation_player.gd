extends AnimationPlayer

func _on_target_select(_pos: Vector2i, _path: PackedVector2Array) -> void:
	play("target_select")
