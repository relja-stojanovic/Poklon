extends Node

func get_game_strategy(data: GameData) -> GameStrategy:
	return data.chase.game_strategy

func get_pathfind(data: GameData) -> Pathfind:
	return data.chase.pathfind

func get_empty_cells(data: GameData) -> Array[Vector2i]:
	return data.chase.empty_cell.data

func start(data: GameData) -> void:
	create_preview(data, data.spawn_amount + 2)
	spawn_elements(data)

func is_game_over(data: GameData, spawn_amount: int) -> bool:
	return data.size*data.size - data.elements.size() <= spawn_amount

func create_preview(data: GameData, spawn_amount: int) -> void:
	var new_preview: Array[int] = []
	new_preview.resize(spawn_amount)
	for i in range(spawn_amount):
		new_preview.set(i, get_game_strategy(data).gen_preview_element())
	data.set_preview(new_preview)
	
func spawn_elements(data: GameData) -> void:
	if is_game_over(data, data.preview.size()):
		Global.game_over()
		return
	
	var empty_cells := get_empty_cells(data).duplicate()
	empty_cells.shuffle()
	for i in data.preview.size():
		var pos: Vector2i = empty_cells[i]
		var element: int = data.preview[i]
		data.add_element(pos, element)
		get_game_strategy(data).execute_match(data, pos)
	create_preview(data, data.spawn_amount)

func valid_pos(data: GameData, pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.y >= 0 and pos.x < data.size and pos.y < data.size

func find_path(data: GameData, from: Vector2i, end: Vector2i) -> ElementPath:
	var pathfind: Pathfind = get_pathfind(data)
	pathfind.astar.set_point_solid(from, false)
	var path: PackedVector2Array = pathfind.astar.get_id_path(from, end, false)
	return ElementPath.new(path)
