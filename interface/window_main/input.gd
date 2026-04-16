extends Node2D

signal input(pos: Vector2i)

func _input(_event: InputEvent) -> void:
	if not Input.is_action_just_pressed("click"):
		return
		
	var mouse_pos: Vector2 = get_local_mouse_position()
	var tile_size: Vector2 = Vector2.ONE*Global.BOARD_SIZE / Global.data.size
	var clicked_pos: Vector2i = floor(mouse_pos / tile_size)

	if GameService.valid_pos(Global.data, clicked_pos):
		input.emit(clicked_pos)
