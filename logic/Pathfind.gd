class_name Pathfind extends RefCounted

var data: GameData
var astar: AStarGrid2D = AStarGrid2D.new()

func _init(init_data: GameData) -> void:
	data = init_data
	
	data.element_added.connect(_on_element_added)
	data.element_removed.connect(_on_element_removed)
	data.elements_removed.connect(_on_elements_removed)
	data.element_moved.connect(_on_element_moved)
	
	astar.region = Rect2i(0, 0, data.size, data.size)
	astar.cell_shape = AStarGrid2D.CELL_SHAPE_SQUARE
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.cell_size = Vector2i(Global.TILE_SIZE, Global.TILE_SIZE)
	astar.update()
	
	sync_pathfinding()

func sync_pathfinding() -> void:
	astar.fill_solid_region(astar.region, false)
	for pos in data.elements:
		astar.set_point_solid(pos, true)

func _on_element_moved(_data: GameData, old_pos: Vector2i, new_pos: Vector2i) -> void:
	astar.set_point_solid(old_pos, false)
	astar.set_point_solid(new_pos, true)
	
func _on_element_added(_data: GameData, pos: Vector2i) -> void:
	astar.set_point_solid(pos, true)
	
func _on_element_removed(_data: GameData, pos: Vector2i) -> void:
	astar.set_point_solid(pos, false)

func _on_elements_removed(_data: GameData, array: Array[Vector2i]) -> void:
	for pos in array:
		astar.set_point_solid(pos, false)
