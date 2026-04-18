class_name WordGameStrategy extends GameStrategy

const LEFT: Vector2i = Vector2i(-1, 0)
const RIGTH: Vector2i = Vector2i(1, 0)

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

func gen_preview_element() -> int:
	if randf() < 0.3:
		var vowels = [Element.LETTER_A, Element.LETTER_E, Element.LETTER_I, Element.LETTER_O, Element.LETTER_U]
		return vowels.pick_random()
	return (randi() % 26) + Element.LETTER_A

func str_at(data: GameData, pos: Vector2i) -> String:
	var element := ElementService.get_at(data, pos)
	if element >= Element.LETTER_A and element <= Element.LETTER_S2:
		return element_to_str[element]
	return ""

func get_letters(data: GameData, start: Vector2i, dir: Vector2i) -> String:
	var output: String = ""
	var current_pos: Vector2i = start + dir
	while GameService.valid_pos(data, current_pos):
		if ElementService.empty_at(data, current_pos):
			break
		output += str_at(data, current_pos)
		current_pos += dir
	return output

func identify_match(text: String) -> MatchSearchResult:
	var n = text.length()
	for length in range(n, 3, -1):
		for start in range(0, n - length + 1):
			var chunk = text.substr(start, length)
			if Lexicon.check_word(chunk):
				return MatchSearchResult.new(start, chunk.length())
	return MatchSearchResult.new(0, 0)

func execute_match(data: GameData, pos: Vector2i) -> bool:
	var l := get_letters(data, pos, LEFT).reverse()
	var r := get_letters(data, pos, RIGTH)
	var text: String = l+str_at(data, pos)+r
	
	var result := identify_match(text)
	var total_matched: Array[Vector2i] = []
	
	for x in range(0, result.size):
		var remove_pos := pos
		remove_pos.x += x - l.length()
		total_matched.append(remove_pos)
	
	if not total_matched.is_empty():
		print(text.substr(result.start, result.size))
		print(total_matched)
		data.remove_elements(total_matched)
		ScoreService.add_score(data, total_matched)

	return false
