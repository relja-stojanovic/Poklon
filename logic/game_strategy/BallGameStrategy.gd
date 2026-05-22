class_name BallGameStrategy extends GameStrategy

const MATCH_MIN: int = 5
const AXES := [
		[Vector2i(1, 0), Vector2i(-1, 0)], # Horizontal -
		[Vector2i(0, 1), Vector2i(0, -1)],  # Vertical  |
		[Vector2i(1, 1), Vector2i(-1, -1)], # Diagonal LR \
		[Vector2i(1, -1), Vector2i(-1, 1)] # Diagonal RL /
	]
var target_element: int

func gen_preview_element(_data: GameData) -> int:
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
	
	var total_matched: Array[Vector2i] = []
	for axis in AXES:
		var matched: Array[Vector2i] = []
		for dir in axis:
			_find_matches_in_direction(pos, data, dir, matched)
		if matched.size() + 1 >= MATCH_MIN:
			total_matched.append_array(matched)
	
	if not total_matched.is_empty():
		total_matched.append(pos)
		data.remove_elements(total_matched)
		
		ScoreService.add_score(data, total_matched.size())
		Chat.info_ball(total_matched.size(), target_element)
		return true
	return false
