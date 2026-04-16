class_name GameChase extends RefCounted

var data: GameData

var pathfind: Pathfind
var empty_cell: EmptyCellHandler
var game_strategy: GameStrategy

func _init(init_data: GameData) -> void:
	data = init_data
	data.chase = self
	
	pathfind = Pathfind.new(data)
	empty_cell = EmptyCellHandler.new(data)
	
	if data.word_mode:
		game_strategy = WordGameStrategy.new()
	else:
		game_strategy = BallGameStrategy.new()
