extends Window

var user_name: String = "Hendikep"

func _ready() -> void:
	content_scale_size = size

func _on_name_input_text_changed(new_text: String) -> void:
	user_name = new_text
	$MarginContainer/VBoxContainer/Confirm.disabled = user_name.is_empty()

func _on_confirm_pressed() -> void:
	var highscore: Highscore = DataHandler.load_file(Path.HIGHSCORE_PATH, Highscore)
	highscore.add_game(user_name, Global.final_score)
	DataHandler.save_file(highscore, Path.HIGHSCORE_PATH)
	get_tree().reload_current_scene.call_deferred()
