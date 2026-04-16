extends PathFollow2D

signal finished()

@export var speed: float = 9

func _ready() -> void:
	h_offset = Global.TILE_SIZE / 2
	v_offset = Global.TILE_SIZE / 2

func _on_path_finished(path: PackedVector2Array) -> void:
	progress_ratio = 0
	
	var tween: Tween = create_tween().set_trans(Tween.TRANS_QUAD)
	var duration: float = float(path.size()) / speed
	
	tween.tween_property(self, "progress_ratio", 1.0, duration)
	await tween.finished
	finished.emit()
