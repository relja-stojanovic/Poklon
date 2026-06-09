extends Node

const TILE_SIZE: int = 120
const BOARD_SIZE: int = 512

var data: GameData = null
var final_score: int = 0
var user_settings: UserSettings = null

func _init() -> void:
	Lexicon.load_lexicon()
	data = DataHandler.load_file(Path.DATA_PATH, GameData)
	user_settings = DataHandler.load_file(Path.USER_SETTINGS_PATH, UserSettings)
	
func game_over() -> void:
	final_score = data.score
	
	var new_data: GameData = GameData.new()
	new_data.size = data.size
	new_data.spawn_amount = data.spawn_amount
	new_data.word_mode = data.word_mode
	data = new_data
	
	get_tree().get_first_node_in_group("game_over_window").show()
	
func quit() -> void:
	DataHandler.save_file(data, Path.DATA_PATH)
	DataHandler.save_file(user_settings, Path.USER_SETTINGS_PATH)
	get_tree().quit()

func to_texture(element: int) -> Vector2i:
	var x: int = element % 5
	var y: int = element / 5
	return Vector2i(x, y)
