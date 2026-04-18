class_name Lexicon extends RefCounted

const PATH: String = "res://logic/lexicography/sr-Latn.json"
static var valid_words: Dictionary = {}

static func load_lexicon() -> void:
	var file = FileAccess.open(PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	valid_words = JSON.parse_string(json_string)
	print("Successfully loaded %s words." % valid_words.size())

static func check_word(word: String) -> bool:
	return valid_words.has(word)
