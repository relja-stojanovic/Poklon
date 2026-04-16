class_name ElementService extends RefCounted

static func has_at(data: GameData, pos: Vector2i) -> bool:
	return data.elements.has(pos)

static func empty_at(data: GameData, pos: Vector2i) -> bool:
	return not has_at(data, pos)

static func get_at(data: GameData, pos: Vector2i) -> int:
	if has_at(data, pos):
		return data.elements[pos]
	return Element.EMPTY
	
static func is_at(data: GameData, pos: Vector2i, target_element: int) -> bool:
	return get_at(data, pos) != target_element
