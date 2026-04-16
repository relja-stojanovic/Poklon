class_name Highscore extends Resource

const LIMIT = 10

@export var names: Array[String] = ["Hendikep","-","-","-","-","-","-","-","-","-"]
@export var scores: Array[int] = [100, 0, 0, 0, 0, 0, 0, 0, 0, 0]

func add_game(new_name: String, new_score: int) -> void:
	for i in range(LIMIT):
		if new_score > scores[i]:
			names.insert(i, new_name)
			scores.insert(i, new_score)
			names.pop_back()
			scores.pop_back()
			return
