class_name BallGameStrategy extends GameStrategy

const MATCH_MIN: int = 5
const AXES := [
		[Vector2i(1, 0), Vector2i(-1, 0)], # Horizontal -
		[Vector2i(0, 1), Vector2i(0, -1)],  # Vertical  |
		[Vector2i(1, 1), Vector2i(-1, -1)], # Diagonal LR \
		[Vector2i(1, -1), Vector2i(-1, 1)] # Diagonal RL /
	]
var target_element: int

func gen_preview_element() -> int:
	return randi() % 7 + Element.BALL_RED

func _find_matches_in_direction(pos: Vector2i, data: GameData, dir: Vector2i, matched: Array[Vector2i]) -> void:
	var current_pos: Vector2i = pos + dir
	while GameService.valid_pos(data, current_pos):
		if ElementService.empty_at(data, current_pos) or ElementService.is_at(data, current_pos, target_element):
			return
		matched.append(current_pos)
		current_pos += dir

func execute_match(data: GameData, pos: Vector2i) -> bool:
	target_element = data.elements[pos]
	
	var total_to_remove: Array[Vector2i] = []
	for axis in AXES:
		var matched: Array[Vector2i] = []
		for dir in axis:
			_find_matches_in_direction(pos, data, dir, matched)
		if matched.size() + 1 >= MATCH_MIN:
			total_to_remove.append_array(matched)
	
	if not total_to_remove.is_empty():
		total_to_remove.append(pos)
		data.remove_elements(total_to_remove)
		
		# Code smell, maybe score calculation shouldn't be here
		var n: int = total_to_remove.size()
		var score: int = ScoreService.get_score(n)
		data.add_score(score)
		Chat.info_ball(target_element, total_to_remove.size())
		return true
	return false
