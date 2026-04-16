class_name ScoreElement extends HBoxContainer

@onready var user_node := %User
@onready var score_node := %Score

func set_data(user: String, score: int) -> void:
	user_node.text = user
	score_node.text = "%s" % score
