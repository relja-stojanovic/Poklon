class_name ShaderSelector extends ColorRect

@export var shader_mode_ball: Material
@export var shader_mode_word: Material
var data: GameData

func _ready() -> void:
	data = Global.data
	if data.word_mode:
		material = shader_mode_word
	else:
		material = shader_mode_ball
