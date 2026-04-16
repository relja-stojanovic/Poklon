extends Label

func _ready() -> void:
	Global.data.score_changed.connect(_on_score_changed)
	update(Global.data)

func _on_score_changed(data: GameData) -> void:
	update(data)

func update(data: GameData) -> void:
	text = ScoreService.to_str(data.score)
