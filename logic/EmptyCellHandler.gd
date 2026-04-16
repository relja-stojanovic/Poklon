class_name EmptyCellHandler extends RefCounted

var data: Array[Vector2i]

func _init(game_data: GameData) -> void:
	game_data.element_added.connect(_on_element_added)
	game_data.element_moved.connect(_on_element_moved)
	game_data.element_removed.connect(_on_element_removed)
	game_data.elements_removed.connect(_on_elements_removed)
	sync_data(game_data)

func sync_data(game_data: GameData) -> void:
	data.clear()
	for x in range(game_data.size):
		for y in range(game_data.size):
			var pos = Vector2i(x, y)
			if not game_data.elements.has(pos):
				data.append(pos)

func _on_element_added(_data: GameData, pos: Vector2i) -> void:
	data.erase(pos)
	
func _on_element_moved(_data: GameData, old_pos: Vector2i, new_pos: Vector2i) -> void:
	data.append(old_pos)
	data.erase(new_pos)
	
func _on_element_removed(_data: GameData, pos: Vector2i) -> void:
	data.append(pos)
	
func _on_elements_removed(_data: GameData, array: Array[Vector2i]) -> void:
	for pos in array:
		data.append(pos)
