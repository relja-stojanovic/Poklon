class_name WordGameStrategy extends GameStrategy

const HORIZONTAL: Vector2i = Vector2i(1, 0)
const VERTICAL: Vector2i = Vector2i(0, 1)
const MIN_LENGHT: int = 4
const element_to_str: Dictionary[int, String] = {
	Element.LETTER_A: "a",
	Element.LETTER_B: "b",
	Element.LETTER_V: "v",
	Element.LETTER_G: "g",
	Element.LETTER_D: "d",
	Element.LETTER_D2: "đ",
	Element.LETTER_E: "e",
	Element.LETTER_Z2: "ž",
	Element.LETTER_Z: "z",
	Element.LETTER_I: "i",
	Element.LETTER_J: "j",
	Element.LETTER_K: "k",
	Element.LETTER_L: "l",
	Element.LETTER_LJ: "lj",
	Element.LETTER_M: "m",
	Element.LETTER_N: "n",
	Element.LETTER_NJ: "nj",
	Element.LETTER_O: "o",
	Element.LETTER_P: "p",
	Element.LETTER_R: "r",
	Element.LETTER_S: "s",
	Element.LETTER_T: "t",
	Element.LETTER_CACI: "ć",
	Element.LETTER_U: "u",
	Element.LETTER_F: "f",
	Element.LETTER_H: "h",
	Element.LETTER_C: "c",
	Element.LETTER_C2: "č",
	Element.LETTER_DZ: "dž",
	Element.LETTER_S2: "š"
	}
var LETTERS = element_to_str.keys()

func gen_preview_element(data: GameData) -> int:
	var counts: Dictionary[int, int] = {}
	for letter in LETTERS:
		counts[letter] = 0
	
	for pos in data.elements:
		var element: int = ElementService.get_at(data, pos)
		counts[element] += 1
	
	var weights: PackedFloat32Array = []
	var total_weight: float = 0.0
	
	for letter in LETTERS:
		var is_vowel = element_to_str[letter] in ["a", "e", "i", "o", "u"]
		var base = 5.0 if is_vowel else 2.0
		var weight = base / (counts[letter] + 1.0)
		weights.append(weight)
		total_weight += weight

	var roll = randf() * total_weight
	var accumulation = 0.0
	for i in range(LETTERS.size()):
		accumulation += weights[i]
		if roll <= accumulation:
			return LETTERS[i]
	
	return LETTERS.pick_random()

func get_line(data: GameData, pos: Vector2i, dir: Vector2i) -> Array[Vector2i]:
	var start: Vector2i = pos
	while GameService.valid_pos(data, start-dir) and not ElementService.empty_at(data, start-dir):
		start -= dir
	
	var current_pos: Vector2i = start
	var output: Array[Vector2i] = []
	while GameService.valid_pos(data, current_pos) and not ElementService.empty_at(data, current_pos):
		output.append(current_pos)
		current_pos += dir
	
	return output

func identify_match(data: GameData, array: Array[Vector2i]) -> Array[Vector2i]:
	var n = array.size()
	
	for length in range(n, MIN_LENGHT-1, -1):
		for start in range(0, n - length + 1):
			var chunk_pos = array.slice(start, start + length)
			var chunk_str = _pos_to_string(data, chunk_pos)
			
			if Lexicon.check_word(chunk_str):
				return chunk_pos
	return []
	
func _pos_to_string(data: GameData, array: Array[Vector2i]) -> String:
	var s = ""
	for pos in array:
		s += element_to_str[ElementService.get_at(data, pos)]
	return s

func execute_match(data: GameData, pos: Vector2i) -> bool:
	var h := get_line(data, pos, HORIZONTAL)
	var v := get_line(data, pos, VERTICAL)
	
	var result_h := identify_match(data, h)
	var result_v := identify_match(data, v)
	
	var unique_pos: Dictionary[Vector2i, bool] = {}
	for element_pos in result_h+result_v:
		unique_pos.set(element_pos, true)
	var total_matched: Array[Vector2i] = unique_pos.keys()
		
	if not total_matched.is_empty():
		if not result_h.is_empty():
			Chat.info_word(_pos_to_string(data, result_h).capitalize())
		if not result_v.is_empty():
			Chat.info_word(_pos_to_string(data, result_v).capitalize())
		data.remove_elements(total_matched)
		ScoreService.add_score(data, total_matched.size()*2)
		return true

	return false
