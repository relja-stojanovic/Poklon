class_name WordGameStrategy extends GameStrategy

const LEFT: Vector2i = Vector2i(-1, 0)
const RIGTH: Vector2i = Vector2i(1, 0)

const element_to_str: Dictionary[int, String] = {
	Element.LETTER_A: "A",
	Element.LETTER_B: "B",
	Element.LETTER_V: "V",
	Element.LETTER_G: "G",
	Element.LETTER_D: "D",
	Element.LETTER_D2: "Đ",
	Element.LETTER_E: "E",
	Element.LETTER_Z2: "Ž",
	Element.LETTER_Z: "Z",
	Element.LETTER_I: "I",
	Element.LETTER_J: "J",
	Element.LETTER_K: "K",
	Element.LETTER_L: "L",
	Element.LETTER_LJ: "LJ",
	Element.LETTER_M: "M",
	Element.LETTER_N: "N",
	Element.LETTER_NJ: "NJ",
	Element.LETTER_O: "O",
	Element.LETTER_P: "P",
	Element.LETTER_R: "R",
	Element.LETTER_S: "S",
	Element.LETTER_T: "T",
	Element.LETTER_CACI: "Ć",
	Element.LETTER_U: "U",
	Element.LETTER_F: "F",
	Element.LETTER_H: "H",
	Element.LETTER_C: "C",
	Element.LETTER_C2: "Č",
	Element.LETTER_DZ: "Dž",
	Element.LETTER_S2: "Š"
}

func gen_preview_element() -> int:
	return randi() % 30 + Element.LETTER_A

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

func execute_match(data: GameData, pos: Vector2i) -> bool:
	var l := get_letters(data, pos, LEFT)
	var r := get_letters(data, pos, RIGTH)
	print("%s%s%s" % [l, str_at(data, pos), r])
	return false
