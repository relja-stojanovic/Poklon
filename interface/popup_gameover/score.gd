extends Label

func _on_window_visibility_changed() -> void:
	text = "Konačni poeni: " + ScoreService.to_str(Global.final_score)
