class_name ElementsDisplay extends Node2D

signal element_select(pos: Vector2i)
signal element_cancel()
signal target_select(pos: Vector2i, path: PackedVector2Array)
signal target_unreachable()

@onready var path_follow := %PathFollow

func _ready() -> void:
	scale = Vector2.ONE*Global.BOARD_SIZE/1.0/Global.TILE_SIZE/Global.data.size

func display_element_select(pos: Vector2i) -> void:
	element_select.emit(pos)

func display_element_cancel() -> void:
	element_cancel.emit()

func display_target_select(pos: Vector2i, path: PackedVector2Array) -> void:
	target_select.emit(pos, path)
	await path_follow.finished

func display_target_unreachable() -> void:
	target_unreachable.emit()
