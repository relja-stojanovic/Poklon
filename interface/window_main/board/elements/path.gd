extends Path2D

signal finished(path: PackedVector2Array)

func _on_moving_element_finished(path: PackedVector2Array) -> void:
	curve.clear_points()
	
	for cell in path:
		curve.add_point(cell*Global.TILE_SIZE)
		
	visible = true
	finished.emit(path)

func _on_path_follow_finished() -> void:
	visible = false
