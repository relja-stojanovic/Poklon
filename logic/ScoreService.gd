class_name ScoreService extends RefCounted

const DISPLAY_COUNT: int = 7
const LIMIT = pow(10, DISPLAY_COUNT) - 1

static func to_str(value: int) -> String:
	var score: int = clamp(value, 0, LIMIT)
	return str(score).pad_zeros(DISPLAY_COUNT)

static func get_score(n: int ) -> int:
	return (n-4)*2*n
